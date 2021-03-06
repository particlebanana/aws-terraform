iam: init_iam 
	@cd $(BUILD)/$@; $(SCRIPTS)/tf-apply-confirm.sh
	@$(MAKE) gen_s3_vars
	@$(MAKE) gen_iam_vars

plan_iam: init_iam
	cd $(BUILD)/iam; $(TF_GET); $(TF_PLAN)

destroy_iam:  
	cd $(BUILD)/iam; $(TF_DESTROY)

show_iam:  
	cd $(BUILD)/iam; $(TF_SHOW) 

init_iam: s3
	mkdir -p $(BUILD)/iam
	rsync -av  $(RESOURCES)/terraforms/iam/ $(BUILD)/iam
	cd $(BUILD)/iam ; ln -sf ../*.tf .

clean_iam:
	rm -rf $(BUILD)/iam

gen_iam_vars:
	cd $(BUILD)/iam; ${SCRIPTS}/gen-tf-vars.sh > $(BUILD)/iam_vars.tf

.PHONY: iam plan_destroy_iam destroy_iam plan_iam init_iam gen_iam_vars clean_iam

