From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 14:23:38 -0800
Subject: [PATCH] ARM: OMAP: don't build hwspinlock in vain
In-Reply-To: <1330859129-354-1-git-send-email-ohad@wizery.com>
References: <1330859129-354-1-git-send-email-ohad@wizery.com>
Message-ID: <20120305222337.GD12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [120304 02:34]:
> Cleanup: don't build mach-omap2/hwspinlock.c if the OMAP hwspinlock
> driver isn't configured.
> 
> This will both shorten build time and avoid registering a device
> which isn't needed.

Thanks applying into fixes-non-critical-part2.

Tony
