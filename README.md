Wing-A-Job

Table of Contents

Project Description
1. Motivation
2. Features
3. Installation
4. Usage
5. Technologies Used
6. Future Enhancements
7. Contributing
8. License

Project Description
Job Application Helper is a Flask-based web application designed to streamline the job application process for students. It allows users to track job applications, mark jobs as applied, and manage their job search more effectively. The application aims to centralize job opportunities and make the recruiting season less overwhelming for students.
Motivation
The inspiration for this project came from the challenges faced during recruiting seasons. Many students struggle to find enough relevant job opportunities and keep track of their applications. This tool addresses these pain points by providing a centralized platform for job tracking and application management.

Features
Mark jobs as applied with a single click
Track application status
Integration with Excel for data storage
RESTful API for easy integration with front-end applications
CORS support for cross-origin requests

Installation
To set up Wing-A-Job, follow these steps:

Clone the repository:
git clone https://github.com/aiswaryakaruturi/wingajob.git

Navigate to the project directory:

Install the required dependencies:
pip install -r requirements.txt

Set up the Excel file path in the app.py file:
file_path = 'path/to/your/excel/file.xlsx'


Usage

Start the Flask server:
Copypython app.py

The application will be accessible at http://localhost:5000
Use the /mark_as_applied endpoint to update job application status:

Send a POST request with JSON data containing the job URL
Example: {"uRL": "https://example.com/job-posting"}



Technologies Used

Flask: Web framework for the backend
Pandas: Data manipulation and analysis
OpenPyXL: Excel file handling
win32com: Windows COM client for Excel operations
Flask-CORS: Cross-Origin Resource Sharing support

Future Enhancements

User authentication and personalized job tracking
Integration with job search APIs for automatic job discovery
Email notifications for application deadlines and status updates
Data visualization for application statistics
Mobile app version for on-the-go job searching and tracking

Contributing
Contributions to the Job Application Helper are welcome! Please follow these steps to contribute:

Fork the repository
Create a new branch for your feature
Commit your changes
Push to the branch
Create a new Pull Request