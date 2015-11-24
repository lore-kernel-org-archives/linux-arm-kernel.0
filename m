From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Nov 2015 13:04:26 +0000
Subject: [PATCH 4/4] spi: mediatek: revise mtk_spi_probe() failure flow
In-Reply-To: <1448332404.27169.4.camel@mhfsdcap03>
References: <1447986080-31410-1-git-send-email-leilk.liu@mediatek.com>
 <1447986080-31410-4-git-send-email-leilk.liu@mediatek.com>
 <20151121133949.GH26072@sirena.org.uk>
 <1448332404.27169.4.camel@mhfsdcap03>
Message-ID: <20151124130426.GL1929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 10:33:24AM +0800, lei liu wrote:
> On Sat, 2015-11-21 at 13:39 +0000, Mark Brown wrote:
> > On Fri, Nov 20, 2015 at 10:21:19AM +0800, Leilk Liu wrote:

> > > This patch revises failure flow while pm_runtime_enable().

> > Why?  This also doesn't apply against current code, please check and
> > resend.

> I don't know. I can git am this patch to spi/for-next. I will resend it,
> please help to apply it again, thanks.

If you don't know why we should make this change then we may as well
just not make it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151124/269831a6/attachment.sig>
