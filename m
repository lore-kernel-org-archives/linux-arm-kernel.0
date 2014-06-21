From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 21 Jun 2014 15:56:20 +0800
Subject: [PATCH 5/5] ARM: dts: imx51-babbage: Fix esdhc setup
In-Reply-To: <1400848384-3226-6-git-send-email-s.hauer@pengutronix.de>
References: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
 <1400848384-3226-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20140621075619.GA16239@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 02:33:04PM +0200, Sascha Hauer wrote:
> - Move cd/wp pinctrl from the hog group to the esdhc groups
> - use gpio for card detection / write protection on esdhc2 since
>   the controller based detection does not work
> - Fix cd gpio polarity for esdhc1. This is wrong and currently
>   only works because the imx esdhc driver ignores the polarity.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied it after fixing up the commit log and pad value.

Shawn
