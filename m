From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 1 Mar 2016 21:41:19 +0800
Subject: [PATCH] ARM: dts: imx53-qsb: Fix gpio button polarity
In-Reply-To: <1456816442-29104-1-git-send-email-s.hauer@pengutronix.de>
References: <1456816442-29104-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20160301134119.GW22051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2016 at 08:14:02AM +0100, Sascha Hauer wrote:
> The polarity of the gpio buttons is defined to '0' which is
> active high. The buttons are active low though which has been verified by
> testing it and by looking into the schematics. While at it use
> defines rathers than numbers for the key codes.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied, thanks.
