From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat, 21 Nov 2015 13:43:29 -0500
Subject: [PATCH V5 2/3] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <6159200.u9U0p8aIkU@wuerfel>
References: <1447620855-4974-1-git-send-email-okaya@codeaurora.org>
 <1447620855-4974-3-git-send-email-okaya@codeaurora.org>
 <6159200.u9U0p8aIkU@wuerfel>
Message-ID: <5650BB51.7090503@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2015 10:58 AM, Arnd Bergmann wrote:

>>  .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  61 ++++
>>  drivers/dma/qcom/Kconfig                           |  10 +
>>  drivers/dma/qcom/Makefile                          |   1 +
>>  drivers/dma/qcom/hidma_mgmt.c                      | 306 +++++++++++++++++++++
>>  drivers/dma/qcom/hidma_mgmt.h                      |  38 +++
>>  drivers/dma/qcom/hidma_mgmt_sys.c                  | 231 ++++++++++++++++
> 
> Each sysfs file API you add needs a documentation in Documentation/ABI/.
> 
> 	Arnd
> 

I'm working on the sysfs documentation now.

Is there any other question regarding the patch series?

If not, I'd like to have a reviewed-by after the next post if acceptable.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
