From: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 09 Aug 2010 12:53:25 +0100
Subject: [PATCH 0/2] mxc_nand: fixes for purposed updates
In-Reply-To: <cover.1281353601.git.baruch@tkos.co.il>
References: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
	<cover.1281353601.git.baruch@tkos.co.il>
Message-ID: <1281354805.26440.4.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-08-09 at 14:38 +0300, Baruch Siach wrote:
> With these patches applied I've tested mxc-nand-pu on a i.MX25 based system.
> 
> Baruch Siach (2):
>   mxc_nand: fix build error
>   mxc_nand: remove unused variables
> 
>  drivers/mtd/nand/mxc_nand.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)

These patches don't apply to the mtd-2.6.git tree.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
