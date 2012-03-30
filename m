From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 30 Mar 2012 16:22:07 +0000
Subject: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain, powerdomain &
 PRM support for AM33XX device
In-Reply-To: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A831841943@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 21:33:51, Hiremath, Vaibhav wrote:
> After some healthy discussion, now we have come to the conclusion and
> decided to handle AM33XX PRM/CM part separately; as AM33XX-PRCM module is
> different than OMAP3 and OMAP4 architecture.
> 
> The difference becomes very interesting/weird when it comes to
> the consistency for register offsets in PRM address space and
> bit-field offsets inside PRM registers,
> So along with Powerdomain data and PRM api's required for AM33XX
> device, this patch series adds,
> 
>  - XXX_RSTST register offset to "struct omap_hwmod_omap4_prcm"
>  - PWRSTCTRL & PWRSTST register offsets to "struct powerdomain"
>  - Logicretstate and mem_on/ret/pwrst/retst mask to "struct
>    powerdomain"
> 
> Testing: This patch series has been boot tested on AM37xEVM and AM335x
>          based BeagleBone community board.
> 
> Thanks to Paul here...for helping and concluding on this,
> shortly I will submit similar patch for CM, clockdomain and clock-tree
> support for AM33xx.
> 
> This patch-series is created on top of "linux-omap/cleanup" branch, and
> also gets applied to "linux-omap/master" branch.
> The patches are also available at -
> https://github.com/hvaibhav/am335x-linux/tree/am335x-prm-cm
> 

Please use "am335x-upstream-staging" branch, to able to boot on BeagleBone
board, due to missing clock & hwmod data.

I am in the process of submitting these patches.

Thanks,
Vaibhav
