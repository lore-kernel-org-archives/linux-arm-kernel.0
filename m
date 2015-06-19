From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 19 Jun 2015 15:31:27 -0500
Subject: [PATCH] arm64/kvm: Add generic v8 KVM target
In-Reply-To: <1434531646-4873-1-git-send-email-suzuki.poulose@arm.com>
References: <1434531646-4873-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <55847C1F.1090606@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2015 04:00 AM, Suzuki K. Poulose wrote:
>   					  &genericv8_target_table);
>   	kvm_register_target_sys_reg_table(KVM_ARM_TARGET_XGENE_POTENZA,
>   					  &genericv8_target_table);
> +	kvm_register_target_sys_reg_table(KVM_ARM_TARGET_GENERIC_V8,
> +					  &genericv8_target_table);
>

Shouldn't you also remove all of the previous lines that return 
&genericv8_target_table?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
