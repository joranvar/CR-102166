DECLARE @ThresholdInMeters FLOAT = 1000000.0;

IF OBJECT_ID('tempdb..#Points1') IS NOT NULL DROP TABLE #Points1;
CREATE TABLE #Points1
    ( PointId INT IDENTITY(1, 1)
    , Point GEOGRAPHY NULL
    );

DECLARE @LowerLatitude FLOAT = -90;
DECLARE @UpperLatitude FLOAT = 90;
DECLARE @LowerLongitude FLOAT = -180;
DECLARE @UpperLongitude FLOAT = 180;

DECLARE @RandomLatitude FLOAT;
DECLARE @RandomLongitude FLOAT;

DECLARE @Counter INT = 100;
WHILE @Counter > 0
  BEGIN
    SELECT @RandomLatitude = ( @UpperLatitude - @LowerLatitude - 1 ) * RAND()
                             + @LowerLatitude;
    SELECT @RandomLongitude = ( @UpperLongitude - @LowerLongitude - 1 ) * RAND()
                              + @LowerLongitude;

    INSERT INTO #Points1
      SELECT GEOGRAPHY::Point(@RandomLatitude, @RandomLongitude, 4326);

    SET @Counter = @Counter - 1;
  END

SELECT [StartPointId] = Points1.PointId
     , [EndPointId] = Points2.PointId
     , [Distance] = Points1.Point.STDistance(Points2.Point)
  FROM #Points1 AS Points1
 INNER JOIN #Points1 AS Points2 ON Points1.PointId <= Points2.PointId
 WHERE Points1.Point.STDistance(Points2.Point) < @ThresholdInMeters;
