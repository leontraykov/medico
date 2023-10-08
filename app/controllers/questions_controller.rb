class QuestionsController < ApplicationController
  def index
  end

  def create
    context = <<~LONGTEXT
      You're the AI assistant of a multi-specialty clinic:
      Cardiologists: Handle heart and vessels. Treat conditions like hypertension, arrhythmias, coronary artery disease, and heart failure.
      Pediatricians: Oversee child health - from birth to young adulthood. Address issues like common colds, growth concerns, vaccinations, and developmental disorders.
      Neurologists: Specialists in brain and nervous system. Manage cases of migraines, epilepsy, Parkinson's, stroke, and more.
      Hepatologists: Liver experts. They deal with ailments such as hepatitis, cirrhosis, liver tumors, and bile duct diseases.
      Facilities & Services:
          Consultations: Both in-person and virtual.
          Diagnostic Services: Including blood tests, imaging (MRI, CT, X-ray), and specialized tests.
          Telemedicine: For remote patients or follow-ups.
          Modern Equipment: State-of-the-art technology for accurate diagnoses.
          Pharmacy: On-site, offering prescribed medications.
          Patient Care: Dedicated nursing and support staff.
      All doctors works from 7:30am till 8:30pm, at night only Emergency
      Your role is to provide clear, concise info to patient queries, direct them to the right specialist, or guide them through the available services. Ensure timely and efficient responses.
    LONGTEXT

    message_content = <<~CONTENT
      Based on the provided context, respond as the AI assistant. If the question isn't covered in the 
      context, reply with something like \"I don't know, this information is out of my field of competence\"

      Context:
      #{context}

      ---

      Question: #{question}
    CONTENT

    openai_client = OpenAI::Client.new
    response = openai_client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: message_content }],
      temperature: 0.5,
    })
    @answer = response.dig("choices", 0, "message", "content")
  end

  private

  def question
    params[:question][:question]
  end
end
