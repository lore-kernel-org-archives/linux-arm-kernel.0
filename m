From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 4 Mar 2015 15:22:49 -0600
Subject: [PATCH v2 1/3] devicetree: bindings: Document qcom,
 msm-id and qcom, board-id
In-Reply-To: <2483237.3YTlNsnOp7@wuerfel>
References: <1425503602-24916-1-git-send-email-galak@codeaurora.org>
 <2483237.3YTlNsnOp7@wuerfel>
Message-ID: <E8050509-B096-4171-9406-EE3831F79D71@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mar 4, 2015, at 3:19 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 04 March 2015 15:13:20 Kumar Gala wrote:
>> The top level qcom,msm-id and qcom,board-id are utilized by bootloaders
>> on Qualcomm MSM platforms to determine which device tree should be
>> utilized and passed to the kernel.
>> 
>> Cc: <devicetree@vger.kernel.org>
>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> 
> This seems to duplicate the root-node compatible strings for no particular
> reason, with a less flexible format. I think it would be better to fix
> the boot loader.

While I wish that was an option, this is a solution that has been shipping on MSM platforms and phones for some time.

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
