From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 26 Mar 2018 15:32:15 +0800
Subject: [PATCH 1/7] ARM: multi_v7_defconfig: add OCOTP driver for NXP SoCs
In-Reply-To: <20180318203442.19759-1-stefan@agner.ch>
References: <20180318203442.19759-1-stefan@agner.ch>
Message-ID: <20180326073214.GB8857@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 18, 2018 at 09:34:36PM +0100, Stefan Agner wrote:
> Enable on-chip OTP NVMEM support for NXP i.MX and VF610 SoCs.
> Since OTP values might be required by drivers required during
> boot, make sure the driver is built-in (e.g. i.MX thermal
> driver).
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Arnd,

The series looks good to me.  In general, I keep myself away from
multi_v7_defconfig changes, but if you expect a pull-request from me, I
can do that.  Let me know how you want to apply the patches.

Shawn
