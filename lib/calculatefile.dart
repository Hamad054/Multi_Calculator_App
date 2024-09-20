// Function to calculate BMI
double calculateBMI(int heightCm, int weightKg) {
  double heightInMeters = heightCm / 100;
  double bmi = weightKg / (heightInMeters * heightInMeters);
  return bmi;
}

// Function to get the BMI status based on the result
String getStatusMessage(double bmi) {
  if (bmi >= 30) {
    return 'You are obese';
  } else if (bmi >= 25) {
    return 'You are overweight';
  } else if (bmi >= 18.5) {
    return 'You have a normal body weight';
  } else {
    return 'Your BMI is low. You are underweight';
  }
}

