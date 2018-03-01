From: tony@atomide.com (Tony Lindgren)
Date: Thu, 1 Mar 2018 15:33:41 -0800
Subject: [PATCH] arm: dts: omap3: Add missing #sound-dai-cells
In-Reply-To: <CAL_Jsq+=dBEH_MFHDgZbNBb75hVzoXsyH-_qE7mKFuGtOixQsw@mail.gmail.com>
References: <20180301202537.30571-2-robh@kernel.org>
 <20180301223243.GI62820@atomide.com>
 <CAL_Jsq+=dBEH_MFHDgZbNBb75hVzoXsyH-_qE7mKFuGtOixQsw@mail.gmail.com>
Message-ID: <20180301233341.GJ62820@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [180301 23:29]:
> On Thu, Mar 1, 2018 at 4:32 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Rob Herring <robh@kernel.org> [180301 12:26]:
> >> dtc now gives the following warnings:
> >>
> >> arch/arm/boot/dts/omap3-gta04a3.dtb: Warning (sound_dai_property): /sound_telephony/simple-audio-card,cpu: Missing property '#sound-dai-cells' in node /ocp at 68000000/mcbsp at 49026000 or bad phandle (referred from sound-dai[0])
> >> arch/arm/boot/dts/omap3-gta04a4.dtb: Warning (sound_dai_property): /sound_telephony/simple-audio-card,cpu: Missing property '#sound-dai-cells' in node /ocp at 68000000/mcbsp at 49026000 or bad phandle (referred from sound-dai[0])
> >> arch/arm/boot/dts/omap3-gta04a5.dtb: Warning (sound_dai_property): /sound_telephony/simple-audio-card,cpu: Missing property '#sound-dai-cells' in node /ocp at 68000000/mcbsp at 49026000 or bad phandle (referred from sound-dai[0])
> >>
> >> Add the missing #sound-dai-cells property.
> >
> > Is this needed for the current -rc or is v4.17 OK?
> 
> 4.17 is fine.
> 
> > Somehow I'm not seeing these with current -rc or next, is
> > there some special option (not W=2 :) that you're using?
> 
> Upstream dtc which I'm working on syncing to for 4.17.

OK let me know if you want to queue along with your other
changes and I'll ack or else I'll apply it up tomorrow.

Regards,

Tony
