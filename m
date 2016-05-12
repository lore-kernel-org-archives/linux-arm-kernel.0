From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 May 2016 13:35:06 -0700
Subject: [PATCH RESEND 0/4] arm: dts: am57xx: Correct the thermal
 thresholds
In-Reply-To: <57316262.80003@ti.com>
References: <1461837949-11116-1-git-send-email-j-keerthy@ti.com>
 <57316262.80003@ti.com>
Message-ID: <20160512203505.GV5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Keerthy <a0393675@ti.com> [160509 21:25]:
> Tony,
> 
> On Thursday 28 April 2016 03:35 PM, Keerthy wrote:
> >Noticed that earlier post had a wrong list name hence resending the
> >series.
> >
> >Currently all the am57xx versions are wrongly re-using the dra7  thermal
> >threholds. Introduing the correct thermal thresholds based on industrial
> >or commercial grade silicon present on the individual boards.
> >
> >Tested on AM57XX-BEAGLE-X15 (Commercial) and AM572X-IDK(Industrial)
> >for the trip_point node sysfs temperatures.
> >
> 
> A Gentle ping on this series.

I already have these in Linux next for v4.7 merge window:

5b6042237dc8 ("ARM: dts: am57xx-idk: Include Industrial grade  thermal thresholds")
266e62f97539 ("ARM: dts: am57xx-beagle-x15: Include the commercial grade thresholds")
cf9b7d5e9cfd ("ARM: dts: am57xx: Introduce industrial grade thermal thresholds")
286db0a516e0 ("ARM: dts: am57xx: Introduce commercial grade thermal thresholds")

Care to check if those are OK? If fixes are needed, please post an
incremental patch against current Linux next.

Regards,

Tony
