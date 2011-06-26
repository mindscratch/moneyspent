$(function() {

    var self = this;

    // fetch the expenses when the page loads
    $.ajax({
        url: "expenses/group_by/payment_method",
        dataType: "json",
        success: function(data) {
            var labels = [],
                    values = [];
            for (var key in data) {
                labels.push("%%.% - " + key);
                values.push(data[key]);
            }
            createChart(labels, values, 125, 135, "Expenses by Payment Method");
        },
        error: function(xhr, status, error) {
            console.log("error: " + xhr.responseText);
        }
    });

    $.ajax({
        url: "expenses/group_by/merchant",
        dataType: "json",
        success: function(data) {
            var labels = [],
                    values = [];
            for (var key in data) {
                labels.push("%%.% - " + key);
                values.push(data[key]);
            }
            createChart(labels, values, 525, 135, "Expenses by Merchant");
        },
        error: function(xhr, status, error) {
            console.log("error: " + xhr.responseText);
        }
    });

    $('#pie_chart').empty();
    var r = Raphael("pie_chart");

    var createChart = function(labels, values, x, y, title) {
        r.g.txtattr.font = "12px 'Fontin Sans', Fontin-Sans, sans-serif";

        var radius = 100;
        r.g.text(x, 10, title).attr({"font-size": 18});

        var pie = r.g.piechart(x, y, radius, values, {legend: labels, legendpos: "east"});
        pie.hover(function () {
            this.sector.stop();
            this.sector.scale(1.1, 1.1, this.cx, this.cy);
            if (this.label) {
                this.label[0].stop();
                this.label[0].scale(1.5);
                this.label[1].attr({"font-weight": 800});
            }
        }, function () {
            this.sector.animate({scale: [1, 1, this.cx, this.cy]}, 500, "bounce");
            if (this.label) {
                this.label[0].animate({scale: 1}, 500, "bounce");
                this.label[1].attr({"font-weight": 400});
            }
        });
    };


});