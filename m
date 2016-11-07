From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Nov 2016 22:20:18 +0100
Subject: [v15, 3/7] powerpc/fsl: move mpc85xx.h to include/linux/fsl
In-Reply-To: <DB6PR0401MB2536B1B2E6AC36BDC8FC540DF8AE0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1477637418-38938-1-git-send-email-yangbo.lu@nxp.com>
 <2723366.1bJeJ7SKI6@wuerfel>
 <DB6PR0401MB2536B1B2E6AC36BDC8FC540DF8AE0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
Message-ID: <1543282.vWjeo4ynTa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 31, 2016 9:35:33 AM CET Y.B. Lu wrote:
> > 
> > I don't see any of the contents of this header referenced by the soc
> > driver any more. I think you can just drop this patch.
> > 
> 
> [Lu Yangbo-B47093] This header file was included by guts.c.
> The guts driver used macro SVR_MAJ/SVR_MIN for calculation.
> 
> This header file was for powerpc arch before. And this patch is to made it as
> common header file for both ARM and PPC.
> Sooner or later this is needed.

Let's discuss it once we actually need the header then, ok?

	Arnd
