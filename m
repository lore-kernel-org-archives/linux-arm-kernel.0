From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 13 Jan 2017 15:35:54 +0000
Subject: [RFC PATCH] arm64: defconfig: enable SMMUv3 config
In-Reply-To: <20170112094729.c2a5tjzsnyubtmte@localhost>
References: <1483962646-33767-1-git-send-email-wangzhou1@hisilicon.com>
 <5876CF7C.8080907@hisilicon.com> <20170112094729.c2a5tjzsnyubtmte@localhost>
Message-ID: <5878F3DA.3090005@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/1/12 9:47, Catalin Marinas wrote:
> On Thu, Jan 12, 2017 at 08:36:12AM +0800, Zhou Wang wrote:
>> On 2017/1/9 19:50, Zhou Wang wrote:
>>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>>> ---
>>>  arch/arm64/configs/defconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>> index 869dded..3520c50 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -440,6 +440,7 @@ CONFIG_PLATFORM_MHU=y
>>>  CONFIG_BCM2835_MBOX=y
>>>  CONFIG_HI6220_MBOX=y
>>>  CONFIG_ARM_SMMU=y
>>> +CONFIG_ARM_SMMU_V3=y
>>>  CONFIG_RASPBERRYPI_POWER=y
>>>  CONFIG_QCOM_SMEM=y
>>>  CONFIG_QCOM_SMD=y
>>
>> I just happened to find there is no SMMUv3 config in arm64 defconfig.
>>
>> Maybe we should add it in defconfig or I miss something.
> 

Hi Arnd,

> It looks fine to me but it's usually the arm-soc guys picking the
> defconfig patches.
> 

It is fine to me.
Is it OK for me to pick up this or will you directly pick up this?
Thanks!

Best Regards,
Wei Xu
