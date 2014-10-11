From: tony@atomide.com (Tony Lindgren)
Date: Sat, 11 Oct 2014 12:08:18 -0700
Subject: [PATCH 00/12] rtc: omap: fixes and power-off feature
In-Reply-To: <20141011093819.GA18988@localhost>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <20141010175409.GL31348@saruman> <20141011093819.GA18988@localhost>
Message-ID: <20141011190817.GA20644@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Johan Hovold <johan@kernel.org> [141011 02:42]:
> On Fri, Oct 10, 2014 at 12:54:22PM -0500, Felipe Balbi wrote:
> > 
> > is this power-off feature "RTC-only mode" ?
> 
> Yes, I believe so, at least as long as RTC power is maintained. The
> pmic_power_en pin can otherwise still be used to power off. 
> 
> On the BeagleBone the PMIC can be configured to enter OFF or SLEEP mode
> on power off, where the latter (and default) mode keeps the RTC power
> supply enabled.
> 
> Thanks for the fast review, Felipe.

Great :) I assume adding the regulator support to this driver should
also help in the 35xx case?

That is assuming that RTC power can be configured as a Linux
regulator on 35xx.

Regards,

Tony
