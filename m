From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 07 Dec 2015 21:48:29 +0100
Subject: [PATCH v2 2/3] soc: dove: add legacy support to PMU driver
In-Reply-To: <20151207204413.GY8644@n2100.arm.linux.org.uk> (Russell King's
 message of "Mon, 7 Dec 2015 20:44:13 +0000")
References: <E1a5j6Q-000879-GO@rmk-PC.arm.linux.org.uk>
 <87r3iy9er5.fsf@free-electrons.com>
 <87mvtm9ejc.fsf@free-electrons.com>
 <20151207204413.GY8644@n2100.arm.linux.org.uk>
Message-ID: <87io4a9e8y.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,
 
 On lun., d?c. 07 2015, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Mon, Dec 07, 2015 at 09:42:15PM +0100, Gregory CLEMENT wrote:
>>  On lun., d?c. 07 2015, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>> 
>> > Hi Russell,
>> >  
>> >  On lun., d?c. 07 2015, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
>> >
>> >> Add support for legacy non-DT Dove to the PMU driver, so that we can
>> >> transition the legacy support over.
>> >>
>> >> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> >
>> > Applied on mvebu/soc (and fixed a conflict in drivers/soc/Makefile)
>> 
>> Eventually I applied it on mvebu/drivers rather than mvebu/soc
>
> Patches 2 and 3 should be applied one after each other to the very
> same branch.  Having patch 3 independent means that things will
> probably break.

Indeed it makes sens, so I put it back on mvebu/soc.

Thanks,

Gregory

>
> -- 
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
