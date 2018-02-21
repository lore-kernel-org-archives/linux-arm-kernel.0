From: dianders@chromium.org (Doug Anderson)
Date: Wed, 21 Feb 2018 15:23:57 -0800
Subject: [PATCH v4 3/4] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
In-Reply-To: <20180219163651.66936056@why.wild-wind.fr.eu.org>
References: <20180216060503.22006-1-rnayak@codeaurora.org>
 <20180216060503.22006-4-rnayak@codeaurora.org>
 <20180219163651.66936056@why.wild-wind.fr.eu.org>
Message-ID: <CAD=FV=WgyX-O8haJp3WpzPodV2f1sokL9hW_qe7R8hVYy3v+sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 19, 2018 at 8:36 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> +                     interrupts = <GIC_SPI 208 IRQ_TYPE_NONE>;
>
> Please do not use IRQ_TYPE_NONE, ever. It doesn't exist in the GIC
> binding. Set it to the actual trigger value.
>

>> +                     interrupts = <GIC_SPI 481 IRQ_TYPE_NONE>;
>
> Same here.

Thanks for the review Marc!


Andy: If I'm reading everything correctly you're the one who would
collect these patches and apply them.  Is that right?  Do they look OK
to you in general?  Would you prefer that Rajendra send out a v5 with
the fixes pointed out by Marc, or would you prefer to fix them up
yourself when applying?  Is now a good time or would you prefer to
wait?

Thanks!  :)

-Doug
