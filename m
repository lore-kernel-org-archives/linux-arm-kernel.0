From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 21 Sep 2018 16:05:33 +0200
Subject: [PATCH] ARM: dts: clearfog: fix sdhci supply property name
In-Reply-To: <20180921135120.GL30658@n2100.armlinux.org.uk> (Russell King's
 message of "Fri, 21 Sep 2018 14:51:20 +0100")
References: <606cef37c2776bdc7dfa3ef578a18c40004e17af.1534878753.git.baruch@tkos.co.il>
 <871s9nhsr2.fsf@bootlin.com>
 <20180921135120.GL30658@n2100.armlinux.org.uk>
Message-ID: <87sh23gd3m.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,
 
 On ven., sept. 21 2018, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Fri, Sep 21, 2018 at 03:42:09PM +0200, Gregory CLEMENT wrote:
>> Hi Baruch,
>>  
>>  On mar., ao?t 21 2018, Baruch Siach <baruch@tkos.co.il> wrote:
>> 
>> > The vmmc phandle, like all power supply property names, must have the
>> > '-supply' suffix.
>> >
>> 
>> I also noticed it a few months ago and then I forgot. However, does it
>> add any value to have this regulator?
>> 
>> Now that I found my note, I considered to just remove this line as well
>> as the regulator node.
>
> The "value" is it's a fuller description of the hardware, and DT is a
> hardware description, not a description of what the software requires.
> So, imho, it's completely correct to specify the vmmc.  As maintainer
> for the Clearfog DT, I'd like it to stay (and be fixed).  Thanks.

OK so: applied on mvebu/dt

Thanks,

Gregory
>
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
> According to speedtest.net: 13Mbps down 490kbps up

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
