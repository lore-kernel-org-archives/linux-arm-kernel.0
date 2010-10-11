From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 11 Oct 2010 18:44:59 +0200
Subject: [PATCH 0/6] SD/MMC driver for MX25/35/51
In-Reply-To: <20101011163255.GA21335@void.printf.net>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
	<20101011163255.GA21335@void.printf.net>
Message-ID: <20101011164459.GB476@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Wolfram Sang (6):
> >   mmc: sdhci-pltfm: Add structure for host-specific data
> >   mmc: sdhci-pltfm: move .h-file into apropriate subdir
> >   mmc: sdhci: introduce private get_ro
> >   mmc: sdhci_pltfm: pass more data on custom init-call
> >   mmc: sdhci-of-esdhc: factor out common stuff
> >   mmc: sdhci-pltfm: add pltfm-driver for imx35/51
> 
> Mind fixing up the >80 char lines in the last two patches?  It's just:

Sigh, I don't think it will help the readability of the code, but if it can't
be helped...

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101011/10b93013/attachment.sig>
