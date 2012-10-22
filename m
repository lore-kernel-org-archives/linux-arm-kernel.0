From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Oct 2012 09:38:26 -0700
Subject: OMAP baseline test results for v3.7-rc2
In-Reply-To: <50857444.9080308@ti.com>
References: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com>
 <50857444.9080308@ti.com>
Message-ID: <20121022163825.GA4730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [121022 09:30]:
> On 10/20/2012 04:26 PM, Paul Walmsley wrote:
> > 
> > * 2430sdp: vfp_reload_hw oops during MMC initialization
> >   - Kernel attempts to save FP registers that don't exist; fix posted:
> >     - http://www.spinics.net/lists/arm-kernel/msg200646.html

Has that one been posted to RMK's patch system?

> > * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
> >   - due to a GPMC bug
> >   - Apparently fixed by http://www.spinics.net/lists/arm-kernel/msg200787.html
> 
> This is now addressed and I have verified it is booting on v3.7-rc2. The
> following patch address this boot problem ...
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8119024ef7363591fd958ec89ebfaee7c18209e3

That's in v3.7-rc2 already, is there some other problem too?

Regards,

Tony
