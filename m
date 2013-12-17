From: shijie8@gmail.com (Huang Shijie)
Date: Tue, 17 Dec 2013 22:12:00 +0800
Subject: [PATCH v3 1/7] mtd: spi-nor: copy the SPI NOR commands to a new
 header file
In-Reply-To: <201312171401.56683.marex@denx.de>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
 <1387184330-14448-2-git-send-email-b32955@freescale.com>
 <201312171401.56683.marex@denx.de>
Message-ID: <20131217141158.GA1168@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 02:01:56PM +0100, Marek Vasut wrote:
> On Monday, December 16, 2013 at 09:58:44 AM, Huang Shijie wrote:
> > This patch adds a new header :spi-nor.h,
> > and copies all the SPI NOR commands and relative macros into this new
> > header.
> > 
> > This hearder can be used by the m25p80.c and other spi-nor controller,
> > such as Freescale's Quadspi.
> > 
> > Signed-off-by: Huang Shijie <b32955@freescale.com>
> 
> It would be much nicer if you also removed the commands in this same patch from 
> the m25p80.c file.
my earlier version did so. :)

So keep it as it is now.

thanks
Huang Shijie
