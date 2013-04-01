From: tony@atomide.com (Tony Lindgren)
Date: Mon, 1 Apr 2013 10:01:48 -0700
Subject: [GIT PULL] ARM: OMAP2+: Serial driver sysc cleanup for 3.10
In-Reply-To: <1363768601-17862-1-git-send-email-santosh.shilimkar@ti.com>
References: <1363768601-17862-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20130401170148.GJ10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130320 01:39]:
> Tony,
> 
> Here is the pull request for OMAP serial driver sysconfig cleanup. The series
> removes all the hackery of sysconfig from UART driver and let runtime backend
> handle it. Without this series serial console is almost un-usable on OMAP5.
> One of the patch touches driver/serial but I got an ack from Greg KH to get
> it queued via OMAP tree.
> 
> 
> The following changes since commit a937536b868b8369b98967929045f1df54234323:
> 
>   Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git for_3.10/omap_serial_sysc_cleanup
> 
> for you to fetch changes up to 0f78c88b107a25561d0830c7fb695134ac7e8892:
> 
>   ARM: OMAP2+: hwmod: Remove sysc slave idle and auto idle apis (2013-03-19 12:07:49 +0530)

Looks like Paul had some comments and has applied some of these,
so ignoring this one for now.

Regards,

Tony 
