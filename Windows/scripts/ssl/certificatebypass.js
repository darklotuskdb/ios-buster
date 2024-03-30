function main() {
        
    var SecTrustEvaluate_prt = Module.findExportByName("Security", "SecTrustEvaluate");
    if (SecTrustEvaluate_prt == null) {
        return;
    }

    var SecTrustEvaluate = new NativeFunction(SecTrustEvaluate_prt, "int", ["pointer", "pointer"]);

    Interceptor.replace(SecTrustEvaluate_prt, new NativeCallback(function(trust, result) {
        var osstatus = SecTrustEvaluate(trust, result);
        Memory.writeU8(result, 1);
        return 0;
    }, "int", ["pointer", "pointer"]));
}

main();
