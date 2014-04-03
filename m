From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 3 Apr 2014 14:47:37 +0800
Subject: [PATCH 2/2] ARM: dts: imx: drop invalid size and address cells
 properties
In-Reply-To: <1396023951-32383-2-git-send-email-l.stach@pengutronix.de>
References: <1396023951-32383-1-git-send-email-l.stach@pengutronix.de>
 <1396023951-32383-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140403064735.GH2801@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 05:25:51PM +0100, Lucas Stach wrote:
> Those two properties should have been set to zero, which
> is the same as not specifying them.
> 
> Having address-cells set to 1 causes OF interrupt
> mapping routines to add 1 to the interrupt-cells
> property and as result fail because all calculations
> are off by one.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
