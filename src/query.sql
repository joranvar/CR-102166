DECLARE @ThresholdInMeters FLOAT = 1000000.0;

SELECT [StartPointId] = Points1.PointId
     , [EndPointId] = Points2.PointId
     , [Distance] = Points1.Point.STDistance(Points2.Point)
  FROM Points1 AS Points1
 INNER JOIN Points1 AS Points2 ON Points1.PointId <= Points2.PointId
 WHERE Points1.Point.STDistance(Points2.Point) < @ThresholdInMeters;
