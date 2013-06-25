From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 25 Jun 2013 19:20:03 +0000 (UTC)
Subject: [PATCH] ARM: omap5: build opp4xxx_data.c
In-Reply-To: <20130621204250.GA16139@kahuna>
References: <201306212229.54238.arnd@arndb.de> <20130621204250.GA16139@kahuna>
Message-ID: <alpine.DEB.2.02.1306251918590.14373@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh,

On Fri, 21 Jun 2013, Nishanth Menon wrote:

> 	/*
> 	 * XXX Will depend on the process, validation, and binning
> 	 * for the currently-running IC. Use OMAP4 data for time being.
> 	 */
> #ifdef CONFIG_PM_OPP
> 	omap5_voltdm_mpu.volt_data = omap446x_vdd_mpu_volt_data;
> 	omap5_voltdm_mm.volt_data = omap446x_vdd_iva_volt_data;
> 	omap5_voltdm_core.volt_data = omap446x_vdd_core_volt_data;
> #endif
> 
> Should we just remove this instead? these are obviously wrong.

Are the OMAP4460 values expected to work and be safe for OMAP5, or not?  
If the latter, please send a patch to remove them.

thanks

- Paul
