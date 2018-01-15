From: guochun.mao@mediatek.com (Guochun Mao)
Date: Mon, 15 Jan 2018 09:58:34 +0800
Subject: [PATCH] mtd: mtk-nor: modify functions' name more generally
In-Reply-To: <5348c8dd-dc78-bdeb-f9d0-5ce20616d69b@wedev4u.fr>
References: <1513561655-10570-1-git-send-email-guochun.mao@mediatek.com>
 <1513561655-10570-2-git-send-email-guochun.mao@mediatek.com>
 <5348c8dd-dc78-bdeb-f9d0-5ce20616d69b@wedev4u.fr>
Message-ID: <1515981514.8823.3.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyrille,

Thank you very much.

BR,
Guochun Mao


On Sun, 2018-01-14 at 16:23 +0100, Cyrille Pitchen wrote:
> Le 18/12/2017 ? 02:47, Guochun Mao a ?crit :
> > Since more and more Mediatek's SoC can use this driver to
> > control spi-nor flash, functions' name with "mt8173_" is
> > no longer properly. Replacing "mt8173_" with "mtk_" will
> > be more accurate to describe these functions' usable scope.
> > 
> > Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
> 
> Applied to the spi-nor/next branch of linux-mtd
> 
> Thanks!
> 
> > ---
> >  drivers/mtd/spi-nor/mtk-quadspi.c |  240 ++++++++++++++++++-------------------
> >  1 file changed, 120 insertions(+), 120 deletions(-)
> > 
