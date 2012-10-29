From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Mon, 29 Oct 2012 12:23:29 -0500
Subject: tidspbridge: ARM common zImage?
Message-ID: <CALLhW=76TG1sFXHmukJ+JN12j9CdbRLMzJdiOvrdorUehrts0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26 October 2012 13:00, Tony Lindgren <tony@atomide.com> wrote:
...
>> > I would also like to move the tidspbridge to the DMA API, but I think we'll
>> > need to move step by step there, and using the OMAP IOMMU and IOVMM APIs as an
>> > intermediate step would allow splitting patches in reviewable chunks. I know
>> > it's a step backwards in term of OMAP IOMMU usage, but that's in my opinion a
>> > temporary nuisance to make the leap easier.
>>
>> Since tidspbridge is in staging I guess it's not a problem, though it
>> sounds to me like using the correct API in the first place is going to
>> make less churn.
>
> Not related to these patches, but also sounds like we may need to drop
> some staging/tidspbridge code to be able to move forward with the
> ARM common zImage plans. See the "[GIT PULL] omap plat header removal
> for v3.8 merge window, part1" thread for more info.

I was trying to find some more info on this, but only found one patch
for tidspbridge to delete an include... it seems that I must try with
these patches and see what explodes since we heavily abuse prcm code
too.

Thanks,

Omar
