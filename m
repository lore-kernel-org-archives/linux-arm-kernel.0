From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 5 Mar 2015 14:23:04 -0600
Subject: [PATCH v2 1/3] devicetree: bindings: Document qcom,
 msm-id and qcom, board-id
In-Reply-To: <7h8ufbjkod.fsf@deeprootsystems.com>
References: <1425503602-24916-1-git-send-email-galak@codeaurora.org>
 <7h8ufbjkod.fsf@deeprootsystems.com>
Message-ID: <07D4E4D1-BF8C-4583-9505-9F321DB10406@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mar 5, 2015, at 1:42 PM, Kevin Hilman <khilman@kernel.org> wrote:

> Kumar Gala <galak@codeaurora.org> writes:
> 
>> The top level qcom,msm-id and qcom,board-id are utilized by bootloaders
>> on Qualcomm MSM platforms to determine which device tree should be
>> utilized and passed to the kernel.
>> 
>> Cc: <devicetree@vger.kernel.org>
>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> 
> Is this the special magic that allows qcom bootloaders to take a kernel
> plus multiple DTBs and figure out which DTB to pass?
> 
> Kevin

yes

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
