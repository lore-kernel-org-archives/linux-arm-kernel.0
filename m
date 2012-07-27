From: b32955@freescale.com (Huang Shijie)
Date: Fri, 27 Jul 2012 18:12:05 +0800
Subject: [PATCH v2 1/3] mtd: nand: Include IMX6 in the list of supported
 SoCs
In-Reply-To: <20120727092959.GF3347@b20223-02.ap.freescale.net>
References: <1343215100-24005-1-git-send-email-festevam@gmail.com>
 <20120727092959.GF3347@b20223-02.ap.freescale.net>
Message-ID: <50126975.9010907@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?07?27? 17:30, Richard Zhao ??:
> We don't need to list all SoCs. Shall we just check MXC or MXS ?
The gpmi nand controller only exits in mx23/mx23/mx50/mx6q. In 
mx53/mx35, we use the mxc-nand controller.
So it's better to list all the supported SoCs here.

Best Regards
Huang Shijie
