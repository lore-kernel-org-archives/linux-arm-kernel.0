From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Dec 2010 17:40:26 -0800
Subject: [PATCH -next] omap2430: hwmod: remove stray declaration
In-Reply-To: <1291403730-3165-1-git-send-email-gadiyar@ti.com>
References: <1291403730-3165-1-git-send-email-gadiyar@ti.com>
Message-ID: <20101218014026.GJ5941@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Anand Gadiyar <gadiyar@ti.com> [101203 11:05]:
> Patch "OMAP2xxx: hwmod: add I2C hwmods for OMAP2420, 2430"
> in linux-next as of 20101203 introduced the following build
> warning - fix this by removing the stray i2c_dev_attr.
> 
> arch/arm/mach-omap2/omap_hwmod_2430_data.c:483: warning: 'i2c_dev_attr' defined but not used

Thanks applying.

Tony
