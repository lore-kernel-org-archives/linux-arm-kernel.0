From: guochun.mao@mediatek.com (Guochun Mao)
Date: Mon, 17 Apr 2017 11:34:32 +0800
Subject: [PATCH v1 1/1] mtd: mtk-nor: set controller's address width
 according to nor flash
In-Reply-To: <e78dba15-80d0-f2c3-c963-a7eb033af58d@wedev4u.fr>
References: <1491381462-21893-1-git-send-email-guochun.mao@mediatek.com>
 <1491381462-21893-2-git-send-email-guochun.mao@mediatek.com>
 <e9eafca3-41a0-7e88-996b-9d1c51f0c132@wedev4u.fr>
 <1492051237.2866.36.camel@mhfsdcap03>
 <3cf1c63e-c56f-2f07-9d16-7ec346758dfa@wedev4u.fr>
 <e78dba15-80d0-f2c3-c963-a7eb033af58d@wedev4u.fr>
Message-ID: <1492400072.2866.39.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyrille,

On Sun, 2017-04-16 at 19:18 +0200, Cyrille Pitchen wrote:
> Le 13/04/2017 ? 10:24, Cyrille Pitchen a ?crit :
> > Hi Guochun,
> > 
> > Le 13/04/2017 ? 04:40, Guochun Mao a ?crit :
> >> Hi Cyrille,
> >>
> >> On Wed, 2017-04-12 at 22:57 +0200, Cyrille Pitchen wrote:
> >>> Hi Guochun,
> >>>
> >>> Le 05/04/2017 ? 10:37, Guochun Mao a ?crit :
> >>>> When nor's size larger than 16MByte, nor's address width maybe
> >>>> set to 3 or 4, and controller should change address width according
> >>>> to nor's setting.
> >>>>
> >>>> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>st
> > 
> > Acked-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> > 
> 
> Applied to github/spi-nor

Thank you very much!

Best regards,
Guochun
