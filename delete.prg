FUNCTION MAIN()
DECLARE cTmpPath := GetEnv("TEMP") + "\cdd-curdir.tmp"
DELETE FILE cTmpPath
RETURN NIL