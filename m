From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 5 Nov 2012 13:33:50 +0100
Subject: [PATCH 0/8] clk: ux500: Fixup smp_twd clk for clk notifiers
In-Reply-To: <20121028225918.GC5411@sortiz-mobl>
References: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com>
 <20121011134458.GB15428@gmail.com>
 <CACRpkdYEukMzMX1Q8nb5zKPMZEZfttzWVC24aOkv2g8SCQtTnQ@mail.gmail.com>
 <20121011151947.GD15428@gmail.com>
 <CAPDyKFof65xAVyOo3FrdS2uYQwB1Wq3553PKj04FR6JXaJsH6Q@mail.gmail.com>
 <20121028225918.GC5411@sortiz-mobl>
Message-ID: <CAPDyKFq50Hnk7TP8pXv_WKRq8p-mP7Lfdc31m-jmU=xLt1Q8UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 October 2012 23:59, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Ulf,
>
> On Fri, Oct 26, 2012 at 10:19:24AM +0200, Ulf Hansson wrote:
>> On 11 October 2012 17:19, Lee Jones <lee.jones@linaro.org> wrote:
>> > On Thu, 11 Oct 2012, Linus Walleij wrote:
>> >
>> >> On Thu, Oct 11, 2012 at 3:44 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> >>
>> >> >> Patches are based on Linus Torvalds tree with latest commit as of okt 10.
>> >> >
>> >> > Hmm... I get:
>> >> >
>> >> > Applying: clk: ux500: Support for prcmu_scalable_rate clock
>> >> > error: drivers/clk/ux500/clk-prcmu.c: does not exist in index
>> >> > error: drivers/clk/ux500/clk.h: does not exist in index
>> >> > Patch failed at 0001 clk: ux500: Support for prcmu_scalable_rate clock
>> >> >
>> >> > So when did drivers/clk/ux500/* arrive?
>> >>
>> >> Exactly here, 10 days ago on Torvalds' master branch:
>> >
>> > Ah I see. Basing patches on commits half way through the merge
>> > window. Good move! ;)
>> >
>> > --
>> > Lee Jones
>> > Linaro ST-Ericsson Landing Team Lead
>> > Linaro.org ? Open source software for ARM SoCs
>> > Follow Linaro: Facebook | Twitter | Blog
>>
>> Samuel, a kind reminder on this, trying to collect acks to be able to
>> advise Mike to take this series through his clk tree. There are two
>> mfd patches.
>> [PATCH 2/8] mfd: db8500: Provide cpufreq table as platform data
>> [PATCH 5/8] mfd: db8500: Connect ARMSS clk to ARM OPP
> Sorry for the delay:
>
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>
>
> Cheers,
> Samuel.
>
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

A kind ping for this this series for you Mike. I believe all patches
has received acks now as well.

Kind regards
Ulf Hansson
