From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Jul 2014 09:38:28 +0800
Subject: [RFC V2] devicetree: Dialog Semiconductor consolidate existing
 vendor prefixes to standardise on 'dlg'
In-Reply-To: <201407151520.s6FFKcjB009745@swsrvapps-01.diasemi.com>
References: <201407151520.s6FFKcjB009745@swsrvapps-01.diasemi.com>
Message-ID: <20140722013827.GM8537@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 04:03:31PM +0100, Opensource [Steve Twiss] wrote:
> From: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
> 
> This patch series updates the device tree vendor prefix for
> Dialog Semiconductor.
> 
> Various methods are currently used throughout the kernel: 'diasemi',
> 'dialog' and 'dlg'. Others have also been suggested.
> 
> This patch set aims to consolidate the usage of the vendor prefix to
> use a common standard. The prefix 'dlg' is used.

...

> Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>

...

>  arch/arm/boot/dts/imx53-smd.dts                    |  2 +-
>  arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |  2 +-

Acked-by: Shawn Guo <shawn.guo@freescale.com>
