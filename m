From: leilk.liu@mediatek.com (lei liu)
Date: Thu, 8 Jun 2017 09:41:03 +0800
Subject: [PATCH 2/3] spi: mediatek: support adjust register define
In-Reply-To: <20170606185730.mrvgvp4hynftwahx@sirena.org.uk>
References: <1496387923-31674-1-git-send-email-leilk.liu@mediatek.com>
 <1496387923-31674-3-git-send-email-leilk.liu@mediatek.com>
 <20170606185730.mrvgvp4hynftwahx@sirena.org.uk>
Message-ID: <1496886063.30249.1.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-06-06 at 19:57 +0100, Mark Brown wrote:
> On Fri, Jun 02, 2017 at 03:18:42PM +0800, Leilk Liu wrote:
> 
> > +	/* some IC design adjust register define */
> > +	bool adjust_reg;
> 
> Can we have a name that's more specific to the particular quirk please?
> The current name will get confusing if some future chip also needs
> slightly different register settings.
> 
thanks for your suggestion, I'll fix it.

> Otherwise this looks good.
