module UsosAuthCommon
  extend ActiveSupport::Concern

  def handle_request(access_token, access_token_secret, service_path)
    access_token = UsosAuthLib::UsosAuthorizer.instance.access_token(session, nil, access_token, access_token_secret)

    response = access_token.get(service_path)
    JSON.parse(response.body)
  rescue StandardError => e
    Rails.logger.error "USOS Handle Request Error: #{e.message}"
  end

  def get_terms_grades(access_token, access_token_secret, term_ids)
    path = "/services/grades/terms2?term_ids=#{term_ids}"
    handle_request(access_token, access_token_secret, path)
  end

  def get_course_grades(access_token, access_token_secret, course_id, term_id)
    path = "/services/grades/course_edition2?course_id=#{course_id}&term_id=#{term_id}"
    handle_request(access_token, access_token_secret, path)
  end

  def get_latest_grades(access_token, access_token_secret)
    path = "/services/grades/latest"
    handle_request(access_token, access_token_secret, path)
  end

  def get_courses(access_token, access_token_secret, course_ids)
    path = "/services/grades/latest?course_ids=#{course_ids}"
    handle_request(access_token, access_token_secret, path)
  end

  def get_user_info(access_token, access_token_secret, fields)
    path = "/services/users/user?fields=#{fields}"
    handle_request(access_token, access_token_secret, path)
  end
end
