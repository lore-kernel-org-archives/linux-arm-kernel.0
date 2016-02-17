From: yong.wu@mediatek.com (Yong Wu)
Date: Thu, 18 Feb 2016 01:52:15 +0800
Subject: [PATCH v8 3/5] memory: mediatek: Add SMI driver
In-Reply-To: <20160216141059.GT18805@8bytes.org>
References: <1453781562-23556-1-git-send-email-yong.wu@mediatek.com>
 <1453781562-23556-4-git-send-email-yong.wu@mediatek.com>
 <56ADE959.2050309@gmail.com> <20160216141059.GT18805@8bytes.org>
Message-ID: <1455731535.10704.8.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-02-16 at 15:11 +0100, Joerg Roedel wrote:
> On Sun, Jan 31, 2016 at 12:00:41PM +0100, Matthias Brugger wrote:
> > 
> > 
> > On 26/01/16 05:12, Yong Wu wrote:
> > >This patch add SMI(Smart Multimedia Interface) driver. This driver
> > >is responsible to enable/disable iommu and control the power domain
> > >and clocks of each local arbiter.
> > >
> > >Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > >Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> > >---
> > 
> > Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> > 
> > Joerg would you mind to take this through your branch?
> 
> Hmm, I somehow missed the patch-set, at least I can't find the v8
> patches in my inbox.
> 
> Yong, can you please re-send with all Acks and other tags added?

Hi Joerg,
  
     I have re-sent v9[1] which has added all the tags yesterday.

     Could you find them in your inbox? If not again, please tell me.

     Thanks.

[1]:http://lists.linuxfoundation.org/pipermail/iommu/2016-February/015713.html

> 
> 
> Thanks,
> 
> 	Joerg
> 
