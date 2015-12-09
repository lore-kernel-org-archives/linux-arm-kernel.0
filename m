From: alison.wang@freescale.com (Huan Wang)
Date: Wed, 9 Dec 2015 08:41:21 +0000
Subject: [PATCH] ARM: multi_v7_defconfig: Enable some drivers for LS1021A
In-Reply-To: <3400541.YhcYNk5DCk@wuerfel>
References: <1449563883-29317-1-git-send-email-b18965@freescale.com>
 <3400541.YhcYNk5DCk@wuerfel>
Message-ID: <BN3PR0301MB0867F04C5F0D9182D4C34D1AFEE80@BN3PR0301MB0867.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tuesday 08 December 2015 16:38:03 Alison Wang wrote:
> > This patch enables some drivers for LS1021A, such as GIANFAR,
> > WATCHDOG, AUDIO, QSPI, I2C, ESDHC, EDMA, FTM.
> > QorIQ Clock Framework and Ramdisk support is also enabled.
> >
> > Signed-off-by: Alison Wang <alison.wang@freescale.com>
> > ---
> 
> I think most of these can be made loadable modules, please do that and
> only leave as much built-in as you need for booting.
> 
> Otherwise looks ok.
> 
> 
[Alison Wang] Thanks for your advice. I will change most drivers as loadable
modules in v2.


Best Regards,
Alison Wang
