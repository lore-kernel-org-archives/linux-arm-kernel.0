From: khilman@ti.com (Kevin Hilman)
Date: Wed, 06 Apr 2011 08:33:32 -0700
Subject: [PATCH] OMAP2+: SR Layer Cleanup.
In-Reply-To: <1301378352-29269-1-git-send-email-shweta.gulati@ti.com> (Shweta
	Gulati's message of "Tue, 29 Mar 2011 11:29:12 +0530")
References: <1301378352-29269-1-git-send-email-shweta.gulati@ti.com>
Message-ID: <87mxk3iecz.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shweta,

Shweta Gulati <shweta.gulati@ti.com> writes:

> As a part of Voltage Layer Cleanup Patches,
> submitted by Kevin Hilman, Voltage domain
> Information is removed from hwmod,
> So the patch removes 'vdd_name' info from omap_hwmod
> and adds that info into dev_attr as SR code uses vdd_name
> to get voltagedomain sructure info.
>
> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>

Thanks for this.  It looks good.

> ---
> It apllies over Voltage Layer Cleanup Patch by
> Kevin Hilman: 
>  https://patchwork.kernel.org/patch/657421/ 

Can you rebase on top of my pm-wip/voltdm_a branch?  It currently
doesn't apply there because the some of the voltage domain names were
changed, e.g. mpu -> mpu_iva, wkup -> wakeup.

Thanks,

Kevin
