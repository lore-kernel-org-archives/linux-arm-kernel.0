From: khilman@ti.com (Kevin Hilman)
Date: Mon, 07 Mar 2011 14:30:12 -0800
Subject: [PATCH V2 0/3]: OMAP4: Update OPP Table and Voltage Rail Values
In-Reply-To: <1299318621-21280-1-git-send-email-shweta.gulati@ti.com> (Shweta
	Gulati's message of "Sat, 5 Mar 2011 15:20:21 +0530")
References: <1299318621-21280-1-git-send-email-shweta.gulati@ti.com>
Message-ID: <87vczuzhqj.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shweta Gulati <shweta.gulati@ti.com> writes:

> The Series Updates OPP Table for MPU, add OPP enteries
> for IVA and update Voltage Rail values for MPU/IVA.
>
> It is based on the Patch which replaces
> Voltage values with Macros, Submitted by 
> Nishanth Menon 
> https://patchwork.kernel.org/patch/607541/
>
> Branch: pm-core
>
> Tested on OMAP4430 SDP.
>
> V2:
> Rebased on pm-core and incorporated
> comments from Nishanth Menon. 

This version looks OK to me.

Will queue for 2.6.39 after I see an Ack from Nishanth.

Thanks,

Kevin

> Shweta Gulati (3):
>   OMAP4: Enable 800 MHz and 1 GHz OPP for OMAP4.
>   OMAP4: Update Voltage Rail Values for MPU/IVA
>   OMAP4: Add IVA OPP enteries.
>
>  arch/arm/mach-omap2/opp4xxx_data.c |   26 ++++++++++++++++----------
>  1 files changed, 16 insertions(+), 10 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
