From: leilk.liu@mediatek.com (lei liu)
Date: Wed, 25 Nov 2015 17:17:53 +0800
Subject: [PATCH 4/4] spi: mediatek: revise mtk_spi_probe() failure flow
In-Reply-To: <20151124130426.GL1929@sirena.org.uk>
References: <1447986080-31410-1-git-send-email-leilk.liu@mediatek.com>
 <1447986080-31410-4-git-send-email-leilk.liu@mediatek.com>
 <20151121133949.GH26072@sirena.org.uk>
 <1448332404.27169.4.camel@mhfsdcap03> <20151124130426.GL1929@sirena.org.uk>
Message-ID: <1448443073.27169.7.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-11-24 at 13:04 +0000, Mark Brown wrote:
> On Tue, Nov 24, 2015 at 10:33:24AM +0800, lei liu wrote:
> > On Sat, 2015-11-21 at 13:39 +0000, Mark Brown wrote:
> > > On Fri, Nov 20, 2015 at 10:21:19AM +0800, Leilk Liu wrote:
> 
> > > > This patch revises failure flow while pm_runtime_enable().
> 
> > > Why?  This also doesn't apply against current code, please check and
> > > resend.
> 
> > I don't know. I can git am this patch to spi/for-next. I will resend it,
> > please help to apply it again, thanks.
> 
> If you don't know why we should make this change then we may as well
> just not make it?

OK. I will write a proper commit message to explain what this patch
does. Thanks.

> _________________
> ______________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
