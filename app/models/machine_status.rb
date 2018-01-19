class MachineStatus < ApplicationRecord
	belongs_to :machine
	validates	:machine_status, presence: true
	validates	:machine_id, presence: true
	
	MACHINE_STATUS_TYPES = ["Shutdown","Operational"]
end
