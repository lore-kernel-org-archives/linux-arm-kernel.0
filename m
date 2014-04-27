From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 27 Apr 2014 08:53:09 +0200
Subject: [PATCH 8/8] ARM: dts: imx27-phytec-phycore-*: Move "iomux" node
 to the bottom of file
In-Reply-To: <1398539710.4978394@f317.i.mail.ru>
References: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
 <1398487933-5683-8-git-send-email-shc_work@mail.ru>
 <20140426190935.GE5858@pengutronix.de>
 <1398539710.4978394@f317.i.mail.ru>
Message-ID: <20140427065309.GJ5858@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 26, 2014 at 11:15:10PM +0400, Alexander Shiyan wrote:
> Sat, 26 Apr 2014 21:09:35 +0200 ?? Sascha Hauer <s.hauer@pengutronix.de>:
> > On Sat, Apr 26, 2014 at 08:52:13AM +0400, Alexander Shiyan wrote:
> > > This patch moves "iomux" node to the bottom of file.
> > > No functional changes.
> > 
> > Why? The nodes are (at least should be) sorted alphabetically.
> 
> Pin definitions look better in one place, at the bottom.
> As far as I know, Shawn supported this position.

If that's the way we want to go then ok. I wasn't aware of this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
