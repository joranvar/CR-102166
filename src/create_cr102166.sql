CREATE TABLE Points1
    ( PointId INT IDENTITY(1, 1) PRIMARY KEY
    , Point GEOGRAPHY NULL
    );

DECLARE @LowerLatitude FLOAT = -90
DECLARE @UpperLatitude FLOAT = 90
DECLARE @LowerLongitude FLOAT = -180
DECLARE @UpperLongitude FLOAT = 180

DECLARE @Counter INT = 1000
WHILE @Counter > 0
  BEGIN
    DECLARE @RandomLatitude FLOAT = ( @UpperLatitude - @LowerLatitude - 1 ) * RAND()
                                    + @LowerLatitude
    DECLARE @RandomLongitude FLOAT = ( @UpperLongitude - @LowerLongitude - 1 ) * RAND()
                                     + @LowerLongitude

    INSERT INTO Points1
      SELECT GEOGRAPHY::Point(@RandomLatitude, @RandomLongitude, 4326)

    SET @Counter = @Counter - 1
  END;
