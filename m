From: tony@atomide.com (Tony Lindgren)
Date: Thu, 26 Mar 2015 12:03:12 -0700
Subject: [PATCH V2 2/2] ARM: dts: am57xx-beagle-x15: Add thermal map to
 include fan and tmp102
In-Reply-To: <20150324151736.GE29155@developer.hsd1.ca.comcast.net>
References: <1427139579-4215-1-git-send-email-nm@ti.com>
 <1427139579-4215-3-git-send-email-nm@ti.com>
 <20150324151736.GE29155@developer.hsd1.ca.comcast.net>
Message-ID: <20150326190311.GE10805@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Eduardo Valentin <edubezval@gmail.com> [150324 08:17]:
> On Mon, Mar 23, 2015 at 02:39:39PM -0500, Nishanth Menon wrote:
> > BeagleBoard-X15 has capability for a fan and has an onboard TMP102
> > temperature sensor as well. This allows us to create a new thermal
> > zone (called, un-imaginatively "board"), and allows us to use some
> > active cooling as temperatures start edge upward in the system by
> > creating a new alert temperature (emperically 50C) for cpu.
> > 
> > NOTE: Fan is NOT mounted by default on the platform, in such a case,
> > all we end up doing is switch on a regulator and leak very minimal
> > current.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Acked-by: Eduardo Valentin <edubezval@gmail.com>

Applying both of these into omap-for-v4.1/fixes-not-urgent thanks.

Tony
