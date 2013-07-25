From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 25 Jul 2013 09:50:13 +0300
Subject: OMAP2430 SDP boot broken after Linus' rmk merge
In-Reply-To: <51F0C841.8000900@ti.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com>
 <20130722184325.GA21614@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com>
 <51EE2AA7.5060503@ti.com>
 <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com>
 <51EFE1DD.8070801@ti.com> <20130724145237.GB21614@n2100.arm.linux.org.uk>
 <51F0C841.8000900@ti.com>
Message-ID: <51F0CAA5.8010108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/07/13 09:40, Tomi Valkeinen wrote:
> On 24/07/13 17:52, Russell King - ARM Linux wrote:
> 
>> I also continue to be disappointed by the lack of things working on the
>> 4430 - it's been a number of years now and _still_ the on-board LCDs do
>> not work.  People have tried to blame that on hardware faults and the
>> like, but they're just being idiotic when they say stuff like that.  It
>> can't be hardware faults when the kernel supplied with the board is able
>> to make them work to the extent that userspace can play back video on all
>> three output devices simultaneously, without hiccup or any imperfection.
>> I don't know whether it's just that the backlight support isn't working
>> or what - because any information on the 4430 seems to be a tightly
>> controlled secret that only a few select people are permitted to know
>> about.  As far as I'm concerned, much of the hardware is a black box to
>> me.
> 
> The 4430SDP's backlight hasn't been working in the mainline due to
> missing support from the TWL driver. But we finally did get that in for
> 3.10 (or maybe 3.9), and booting 3.10 non-DT kernel brings up the
> backlights. However, the BL doesn't work yet with DT boot, so again with
> 3.11, with no board files, the BL is out... Sigh.

Ah, sorry, I take that back. Backlight seems to be working fine with 3.11.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130725/de5e0ef5/attachment.sig>
