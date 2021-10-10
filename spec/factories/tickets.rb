FactoryBot.define do
  factory :ticket do
    name {'ticket sample name'}
    description {'ticket sample description'}
    author factory: :user
    project
  end
end
