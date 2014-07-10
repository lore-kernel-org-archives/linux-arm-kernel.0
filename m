From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Jul 2014 23:43:05 -0700
Subject: [RFC PATCH 3/4] tty: serial: 8250 core: add runtime pm
In-Reply-To: <53BD6EB3.4020305@linutronix.de>
References: <1404491651-1388-1-git-send-email-bigeasy@linutronix.de>
 <1404491651-1388-3-git-send-email-bigeasy@linutronix.de>
 <20140707142056.46f61cf9@alan.etchedpixels.co.uk>
 <20140709111705.GR28884@atomide.com>
 <53BD291D.3040307@linutronix.de>
 <20140709114837.GU28884@atomide.com>
 <53BD38D3.2000204@linutronix.de>
 <20140709151242.GY28884@atomide.com>
 <53BD6EB3.4020305@linutronix.de>
Message-ID: <20140710064305.GG28884@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140709 09:35]:
> On 07/09/2014 05:12 PM, Tony Lindgren wrote:
> > And also please note that for runtime PM the wake-up events need
> > to be always enabled, so the device_may_wakeup() checks should
> > be only implemented for suspend and resume. I think I got that
> > corrected for most part in omap-serial.c recently, but knowing
> > that might reduce the confusion a bit :)
> 
> Ehm. I also added it to omap_8250_pm() as it is done in omap-serial (in
> serial_omap_pm()). Should I get rid of it in the latter?

Yes, I commented on that patch also.

Regards,

Tony
