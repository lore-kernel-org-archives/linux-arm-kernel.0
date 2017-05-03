From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 3 May 2017 16:22:53 +0800
Subject: [PATCH v2 1/7] ARM: dts: i.MX: Reintroduce 'anatop-enable-bit'
 where appropriate
In-Reply-To: <20170418150133.31679-2-andrew.smirnov@gmail.com>
References: <20170418150133.31679-1-andrew.smirnov@gmail.com>
 <20170418150133.31679-2-andrew.smirnov@gmail.com>
Message-ID: <20170503082252.GA18578@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 08:01:27AM -0700, Andrey Smirnov wrote:
> Now that support for 'anatop-enable-bit' has been added to ANADIG
> driver, reintroduce 'anatop-enable-bit' for all applicable LDOs.
> 
> Cc: yurovsky at gmail.com
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Please use 'imx' instead of 'i.MX' in subject prefix to make it more
consistent with other patches in the series.

Shawn
