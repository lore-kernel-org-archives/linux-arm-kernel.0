From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 29 Apr 2014 19:12:14 +0530
Subject: [PATCH V3 00/20] bus: omap_l3_noc: driver cleanups and support
 for DRA7/AM4372
In-Reply-To: <1398698101-25513-1-git-send-email-nm@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1398698101-25513-1-git-send-email-nm@ti.com>
Message-ID: <535FAC36.10408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 April 2014 08:44 PM, Nishanth Menon wrote:
> V3: has the following changes (w.r.t v2):
> 	- fixed relaxed commit message and usage.
> 	- AM437x internal documents showed that:
> 		- new master information updated into the data
> 		- masterid register definition is different from OMAP4-DRA7 - some
> 		  additional parsing is done in hardware to "avoid s/w parsing"
> 	- Additional testing information showed logic fail for masking "unclearable"
> 		new patch added to series - patch #15
> 	- Picked up previous acks and tested by - minor changes verified

Tested the series on AM437x ePOS EVM and works great.

Tested-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
