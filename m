From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 May 2016 13:46:02 -0700
Subject: [PATCH V2] ARM: dts: am57xx-idk-common: Fix input supply names
In-Reply-To: <1462541877-20032-1-git-send-email-nm@ti.com>
References: <1462541877-20032-1-git-send-email-nm@ti.com>
Message-ID: <20160512204601.GY5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [160506 06:39]:
> Palmas Regulator is an exception and does not follow the standard
> "vin-supply" common definitions for all regulators, as a result of this,
> the input supplies are not reported to regulator framework, with the
> obvious result of not being appropriately mapped. Fix the same.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V1:
> 	- fix up fat fingered deletion of regulator name of ldortc
> V1: https://patchwork.kernel.org/patch/9028201/

Applying into omap-for-v4.7/dt as a fix for the merge window.

Tony
