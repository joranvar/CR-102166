CREATE TABLE Points1
    ( PointId INT IDENTITY(1, 1)
    , Point GEOGRAPHY NULL
    );

DECLARE @LowerLatitude FLOAT = -90
DECLARE @UpperLatitude FLOAT = 90
DECLARE @LowerLongitude FLOAT = -180
DECLARE @UpperLongitude FLOAT = 180

DECLARE @RandomLatitude FLOAT
DECLARE @RandomLongitude FLOAT

DECLARE @Counter INT = 1000
WHILE @Counter > 0
  BEGIN
    SELECT @RandomLatitude = ( @UpperLatitude - @LowerLatitude - 1 ) * RAND()
                             + @LowerLatitude
    SELECT @RandomLongitude = ( @UpperLongitude - @LowerLongitude - 1 ) * RAND()
                              + @LowerLongitude

    INSERT INTO Points1
      SELECT GEOGRAPHY::Point(@RandomLatitude, @RandomLongitude, 4326)

    SET @Counter = @Counter - 1
  END;
