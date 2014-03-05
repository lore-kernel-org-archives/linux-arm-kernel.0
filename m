From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Mar 2014 11:50:53 -0800
Subject: [RESEND Patch 0/9] dts pending patches for TI omap
In-Reply-To: <1393858226-32595-1-git-send-email-mugunthanvnm@ti.com>
References: <1393858226-32595-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <20140305195053.GG7599@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mugunthan V N <mugunthanvnm@ti.com> [140303 06:53]:
> Benoit/Tony
> 
> Here I am send all the pending dt patches that can go into 3.15 merge window,
> all the patches were already posted to mailing list and has beed reviewed.
> 
> I have rebased the patches on top of
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git omap-for-v3.15/dt
> and fixed all the merge conflicts.
> 
> Pasting the mail archive for the patches series
> 
> * Add ABB device nodes
> http://linux-kernel.2935.n7.nabble.com/PATCH-0-4-ARM-dts-OMAP3630-Add-ABB-device-nodes-td794852.html
> 
> * MMC hot plug support
> http://mail.blameitonlove.com/lists/linux-omap/msg101933.html
> Dropped [PATCH 2/3] ARM: dts: am335x-evmsk: add SD card hotplug support as this
> is already merged with commit id 29ea5efb0bb612d352aa360de26e2095cb230e4a
> 
> * DRA7 Cross bar DTS patches
> Cross bar driver has been pulled for next merge, so the dts patches can also
> be pulled for next merge window.
> 
> Here is the pull request for the same patch series.
> 
> The following changes since commit f777ba1780584b100ab9664cc06d04f3bb273a84:
> 
>   Merge tag 'for_3.15/dts_signed' of git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt into omap-for-v3.15/dt (2014-03-02 14:22:03 -0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.ti.com/~mugunthanvnm/ti-linux-kernel/linux.git omapdt-for-3.15
> 
> for you to fetch changes up to 5f78b45aa45c5b2c4de895c3b0740fda4684dae4:
> 
>   ARM: DTS: DRA7: Add routable-irqs property for gic node (2014-03-03 19:53:25 +0530)

Thanks applying all except for the crossbar ones into
omap-for-v3.15/dt.

Please resend the last three patches once the dependencies
are merged to mainline kernel as otherwise the interrupt
nubers are all wrong without the crossbar driver related
code.

Regards,

Tony
