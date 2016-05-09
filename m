From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 May 2016 12:42:59 -0700
Subject: [PATCH] ARM: dts: Fix igepv5 audiopwon-gpio
In-Reply-To: <57304CB3.5010601@collabora.com>
References: <1462474581-13865-1-git-send-email-tony@atomide.com>
 <1b37fbdd-67f0-e9e3-d442-bdc0bd74397b@ti.com>
 <57304CB3.5010601@collabora.com>
Message-ID: <20160509194258.GJ5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enric Balletbo i Serra <enric.balletbo@collabora.com> [160509 01:41]:
> 
> 
> On 09/05/16 10:34, Peter Ujfalusi wrote:
> > On 05/05/16 21:56, Tony Lindgren wrote:
> >> Playing audio works on omap5-uevm, but produces an "Unhandled fault:
> >> imprecise external abort (0x1406) at 0x00000000" error on igepv5.
> >>
> >> Looks like the twl6040 audpwron GPIO pin is different for these
> >> boards. Let's fix the issue by configuring the audpwron in the
> >> board specific dts file.
> >>
> >> Cc: Agust? Fontquerni <af@iseebcn.com>
> >> Cc: Eduard Gavin <egavin@iseebcn.com>
> >> Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>
> 
> 
> Hey, can you change the email address for this one
> 
> Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

OK. Maybe you guys should send a patch for MAINTAINERS entry
for this board so it's easier to figure out who to send the
emails to?

Regards,

Tony
