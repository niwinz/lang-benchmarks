microtime = require("microtime")
_ = require("lodash")

var generateList = function() {
    var result = [];
    _.each(_.range(0, 100), function(i) {
        var subresult = [];
        _.each(_.range(0, 500), function(y) {
            subresult.push(_.random(500));
        })

        result.push(subresult);
    });

    return result;
}


var bench = function(name, func, data) {
    var tInit = microtime.now();
    var result = func(data);
    var tEnd = microtime.now();

    console.log(name + ":  Elapsed time: " + ((tEnd - tInit) / 1000) + " msecs ( Result: " + result + " )");
}


var benchFn1 = function(data) {
    var total = 0;

    for (var i=0; i<data.length; i++) {
        total += data[i].reduce(function(a, b) { return a + b; }, 0)
    }

    return total;
}

var testData = generateList();
bench("[NodeJS ! Array Sum]", benchFn1, testData);
