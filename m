From: cpandya@codeaurora.org (Chintan Pandya)
Date: Wed, 28 Mar 2018 17:52:53 +0530
Subject: [PATCH v5 1/4] ioremap: Update pgtable free interfaces with addr
In-Reply-To: <201803281954.xld7X6dW%fengguang.wu@intel.com>
References: <1522157100-16879-2-git-send-email-cpandya@codeaurora.org>
 <201803281954.xld7X6dW%fengguang.wu@intel.com>
Message-ID: <37565406-dc0d-b23a-a8e8-27767590c9f1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/28/2018 5:20 PM, kbuild test robot wrote:
>   @725  		if (!pmd_free_pte_page(&pmd[i]))
My bad ! Will fix this in v7

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
