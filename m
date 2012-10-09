From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 9 Oct 2012 13:00:50 +0200
Subject: Booting vanilla kernel on the beaglebone
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB39685@DBDE01.ent.ti.com>
References: <20120930082802.GA15392@netboy.at.omicron.at>
 <50693ECD.4000000@ti.com>
 <20121008191657.GA3281@netboy.at.omicron.at>
 <79CD15C6BA57404B839C016229A409A83EB39685@DBDE01.ent.ti.com>
Message-ID: <20121009110049.GB2274@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 05:57:22AM +0000, Hiremath, Vaibhav wrote:
> On Tue, Oct 09, 2012 at 00:46:57, Richard Cochran wrote:
> > 2. Can you post your .config?
> > 
> 
> I use omap2plus_defconfig + CONFIG_ARM_APPENDED_DTB + CONFIG_ARM_ATAG_DTB_COMPAT and nothing more.
                                         ^
-----------------------------------------+  ???

But in the u-boot console example you post, you load the dtb into
memory.

Confused,
Richard
