From: gerg@snapgear.com (Greg Ungerer)
Date: Tue, 5 Jun 2012 23:24:29 +1000
Subject: Freescale fec.c driver breakage
In-Reply-To: <20120605124844.GR30400@pengutronix.de>
References: <4FCC3CB4.5030107@snapgear.com>
 <20120604081937.GH30400@pengutronix.de>
 <20120604091616.GA3943@opensource.wolfsonmicro.com>
 <4FCDAD5B.8010106@snapgear.com>
 <20120605094141.GE23408@opensource.wolfsonmicro.com>
 <4FCDF8BE.6010509@snapgear.com> <20120605124844.GR30400@pengutronix.de>
Message-ID: <4FCE088D.1060604@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2012 10:48 PM, Sascha Hauer wrote:
> On Tue, Jun 05, 2012 at 10:17:02PM +1000, Greg Ungerer wrote:
>>
>>> clkdev
>>> provides an abstraction which can map these onto the platform, even if
>>> you don't use the generic clk API clkdev is still very useful and will
>>> help with a lot of these issues.
>>
>> In this specific case I don't know what the ipg or ahb clocks are on iMX
>> (Sascha?), but there is nothing equivalent to them in the FEC cores used
>> on existing ColdFire CPUs. They seem to be platform specific (iMX) more
>> than FEC driver specific.
>
> I am sure the Coldfire FEC also needs clocks to work. Just like Mark
> said, they may be not software controllable. The names 'ipg' and 'ahb'
> may be i.MX specific though.

Well, yeah, of course there are clocks involved. But you pretty much
hit the point here. 'ipg' and 'ahb' here are platform specific.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
