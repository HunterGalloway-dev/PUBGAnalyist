// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

var t = ($('.scrims_all').data('temp'))



died_count = [t.died_1st, t.died_2nd, t.died_3rd, t.died_4th]
// Pie Chart Example
var ctx = document.getElementById("myPieChart");
var myPieChart = new Chart(ctx, {
  type: 'doughnut',
  data: {
    labels: ["Died 1st", "Died 2nd", "Died 3rd", "Died 4th"],
    datasets: [{
      data: died_count,
      backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc','#f6c23e'],
      hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf','#f4b10b'],
      hoverBorderColor: "rgba(234, 236, 244, 1)",
    }],
  },
  options: {
    maintainAspectRatio: false,
    tooltips: {
      backgroundColor: "rgb(255,255,255)",
      bodyFontColor: "#858796",
      borderColor: '#dddfeb',
      borderWidth: 1,
      xPadding: 15,
      yPadding: 15,
      displayColors: false,
      caretPadding: 10,
    },
    legend: {
      display: false
    },
    cutoutPercentage: 80,
  },
});

console.log(ctx)
