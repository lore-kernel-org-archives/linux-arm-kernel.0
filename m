From: sdu.liu@huawei.com (Liu hua)
Date: Sat, 12 Apr 2014 12:25:36 +0800
Subject: [PATCH v2 1/2] ARM : DMA : remove useless information about DMA
In-Reply-To: <alpine.LFD.2.11.1404112252050.980@knanqh.ubzr>
References: <1397203252-22977-1-git-send-email-sdu.liu@huawei.com>
 <1397203252-22977-2-git-send-email-sdu.liu@huawei.com>
 <alpine.LFD.2.11.1404112252050.980@knanqh.ubzr>
Message-ID: <5348C040.1060305@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

Your version is better. you tell me this in the former letters.
So I am very sorry to forget to check that.

May be I should remake this second patch to fit your change. What do
you think about that patch?

Liu Hua

On 2014/4/12 11:12, Nicolas Pitre wrote:
> On Fri, 11 Apr 2014, Liu Hua wrote:
> 
>> Because commit e9da6e9905e6 has remove custom consistent dma
>> region. So the related variable and document should be removed
>>
>> Signed-off-by: Liu Hua <sdu.liu@huawei.com>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> Incidentally I sent an identical patch to RMK's patch system:
> 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8023/1
> 
> Either version is fine with me.
> 
> 
> Nicolas
> 
> 
