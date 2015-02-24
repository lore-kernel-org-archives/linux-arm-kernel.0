From: tony@atomide.com (Tony Lindgren)
Date: Tue, 24 Feb 2015 10:03:10 -0800
Subject: [PATCH] ARM: dts: am335x-bone*: usb0 is hardwired for peripheral
In-Reply-To: <20150224161941.GM29829@saruman.tx.rr.com>
References: <1424794243-23394-1-git-send-email-robertcnelson@gmail.com>
 <20150224161941.GM29829@saruman.tx.rr.com>
Message-ID: <20150224180309.GH11056@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150224 08:23]:
> On Tue, Feb 24, 2015 at 10:10:43AM -0600, Robert Nelson wrote:
> > Fixes: http://bugs.elinux.org/issues/127
> > 
> > the bb.org community was seeing random reboots before this change.
> > 
> > Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> 
> that's a dead giveaway considering the connector in the board :-)
> 
> Thanks
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>

Applying into omap-for-v4.0/fixes thanks.

Tony
