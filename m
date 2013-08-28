From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 28 Aug 2013 09:41:37 +0800
Subject: [PATCH v8 1/8] ARM: debug: support debug ll on hisilicon soc
In-Reply-To: <20130825161953.GV6617@n2100.arm.linux.org.uk>
References: <1377336603-10303-1-git-send-email-haojian.zhuang@linaro.org>
 <1377336603-10303-2-git-send-email-haojian.zhuang@linaro.org>
 <20130825161953.GV6617@n2100.arm.linux.org.uk>
Message-ID: <CAD6h2NQv737n9h+QZLo7f35G-sTOVzpO+Xe2gXDizo0hz8geJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 August 2013 00:19, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Aug 24, 2013 at 05:29:56PM +0800, Haojian Zhuang wrote:
>> Support UART0 debug ll on Hisilicon Hi3620 SoC & Hi3716 SoC.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>  arch/arm/Kconfig.debug | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index 814d224..bba9662 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -194,6 +194,22 @@ choice
>>                 Say Y here if you want kernel low-level debugging support
>>                 on HI3716 UART.
>>
>
> I'm having problems applying this patch - I don't have the above context
> lines in my tree, or anything remotely resembling them.  Neither can I
> find anything remotely similar in mainline.
>
> What did you generate this patch against?  It can't be v3.11-rc6 as you
> put in your KernelVersion: line for the patch system.
>
> Your diff above says that this was generated against blob 814d224, which
> doesn't exist in mainline either.  Neither does it seem to appear in
> my build tree which includes arm-soc's for-next branch.

Because there's some optimization on debug ll in your tree, I only find those
commits in linux-next git tree. So I based this commit in linux-next.

Could you help me to figure out which branch should I base in your git tree?
Since I can't find a right one.

Regards
Haojian
