From: khilman@ti.com (Kevin Hilman)
Date: Mon, 07 May 2012 11:12:23 -0700
Subject: [PATCH 1/2 v4] ARM: OMAP2+: omap_hwmod: Add api to enable/disable
 module level wakeup events
In-Reply-To: <1335338237-4095-1-git-send-email-govindraj.raja@ti.com>
 (Govindraj R.'s message of "Wed, 25 Apr 2012 12:47:17 +0530")
References: <1335276552-24340-1-git-send-email-govindraj.raja@ti.com>
 <1335338237-4095-1-git-send-email-govindraj.raja@ti.com>
Message-ID: <874nrr508o.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> From: "Govindraj.R" <govindraj.raja@ti.com>
>
> On 24xx/34xx/36xx Module level wakeup events are enabled/disabled using
> PM_WKEN1_CORE/PM_WKEN_PER regs.
>
> Add api to control the module level wakeup mechanism from info provided from
> hwmod data.

Can you rework this slightly on top of the new SoC detection support
recently added to hwmod[1].   That series adds support for init-time, SoC
specific function pointers for this kind of SoC specific feature.

Kevin

[1] git://git.pwsan.com/linux-2.6 hwmod_soc_conditional_cleanup_3.5
