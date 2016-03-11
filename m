From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 11 Mar 2016 12:00:57 -0500
Subject: [PATCH V2 3/3] vfio, platform: add QTI HIDMA reset driver
In-Reply-To: <1457715275-11925-4-git-send-email-okaya@codeaurora.org>
References: <1457715275-11925-1-git-send-email-okaya@codeaurora.org>
 <1457715275-11925-4-git-send-email-okaya@codeaurora.org>
Message-ID: <56E2F9C9.4070208@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/11/2016 11:54 AM, Sinan Kaya wrote:
> VFIO_PLATFORM_MODULE_ALIAS("qcom,hidma-1.0");
> +VFIO_PLATFORM_MODULE_ALIAS("QCOM8061");

I forgot to rename these to MODULE_ALIAS_VFIO_PLATFORM_RESET.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
