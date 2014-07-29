From: xuwei5@hisilicon.com (xuwei)
Date: Tue, 29 Jul 2014 16:09:24 +0800
Subject: [PATCH v5 0/8] enable Hisilicon HIX5HD2 SoC
In-Reply-To: <20140729064027.GE32359@quad.lixom.net>
References: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
 <20140729064027.GE32359@quad.lixom.net>
Message-ID: <53D756B4.50907@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2014/7/29 14:40, Olof Johansson wrote:
> On Mon, Jul 28, 2014 at 08:51:15PM +0800, Haojian Zhuang wrote:
>> Changelog:
>> v5:
>>   * Use CPU_OF_DECLARE_METHOD().
>>   * State "hisilicon,cpuctrl" in documents.
>>   * Set PL310 L2 aux value in machine descriptor.
>>   * Use enable-method property for smp in dts file.
>>   * Move reset code from machine platform driver into power reset driver.
>>   * Move HIP04 debug uart into another patch series.
> 
> Usually there's some more description in the cover letter than just the
> changelog.

Hi Olof,

> Anyway, my question is this: what's the plan for upstreaming of this SoC? Is it
> a mobile-only SoC, or has it been used (or will it be used) in other embedded
> use cases, public development boards and the like?

HiX5HD2 is for the STB market.
Hisilicon has already made some public development boards for Linaro and hope
it could be used in Linaro Home Group.
And if you are interesting about it, we could send one to you.

There are several phases for upstreaming of this SoC.
At the first phase, it includes the basic SoC(earlycon, gic, timer, L2 cache, 
SMP and reboot), net, emc, USB and clock.

> If it is a mobile-targeted product, what is the plan and rough timeline
> for upstreaming things such as display/graphics and power management
> components?

About the display/graphics/video/audio, we are still discussing how to upstream.
There are two limitations. One is the code we have now does not adapt with kernel.
The other is the policy of company which part is allowed to upstream.

But anyway, we hope we could do upstreaming.

Best Regards,
Wei

> 
> Thanks!
> 
> 
> -Olof
> 
> 
> 
