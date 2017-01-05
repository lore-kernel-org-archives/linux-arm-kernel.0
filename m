From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 05 Jan 2017 14:04:43 +0100
Subject: [PATCH 1/5] ARM: dts: armada388-clearfog: add phy reset gpio-hog
In-Reply-To: <20170105103134.GS14217@n2100.armlinux.org.uk> (Russell King's
 message of "Thu, 5 Jan 2017 10:31:35 +0000")
References: <E1cO4UH-0008SR-GW@rmk-PC.armlinux.org.uk>
 <E1cO4Vz-00005t-8n@rmk-PC.armlinux.org.uk>
 <871swig5b3.fsf@free-electrons.com>
 <20170105101620.GR14217@n2100.armlinux.org.uk>
 <87zij5dckj.fsf@free-electrons.com>
 <20170105103134.GS14217@n2100.armlinux.org.uk>
Message-ID: <87eg0hd5ec.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,
 
 On jeu., janv. 05 2017, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Thu, Jan 05, 2017 at 11:29:48AM +0100, Gregory CLEMENT wrote:
>> Hi Russell King,
>>  
>>  On jeu., janv. 05 2017, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
>> 
>> > On Wed, Jan 04, 2017 at 05:26:08PM +0100, Gregory CLEMENT wrote:
>> >> Hi Russell,
>> >>  
>> >>  On lun., janv. 02 2017, Russell King <rmk+kernel@armlinux.org.uk> wrote:
>> >> 
>> >> 
>> >> It would be nice to have some word here about this patch. Especially why
>> >> we need it now. I guess it is for being less dependent on the
>> >> initialization done by the bootloader but maybe you have other reasons.
>> >
>> > I'm not sure I follow.  This is adding it to the new platform, not the
>> > old one.  I guess I should've rolled this into the patch creating the
>> > clearfog-base dts file, and this question wouldn't have come up.
>> >
>> 
>> Indeed I missed the fact that it was on the new board as all the other
>> patches were related to the common part.
>> 
>> Do you agree that I squash this patch into the "ARM: dts:
>> armada388-clearfog: add base model DTS file" patch?
>
> Yep, thanks.

It's done and it is also part of mvebu/for-next now.

Gregory

>
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
