From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 14 Oct 2017 23:38:30 +0800
Subject: [PATCH 4/7] ARM: dts: imx6ul-txul: use panel-simple driver for LCD
In-Reply-To: <1507891383-15452-5-git-send-email-LW@KARO-electronics.de>
References: <1507891383-15452-1-git-send-email-LW@KARO-electronics.de>
 <1507891383-15452-5-git-send-email-LW@KARO-electronics.de>
Message-ID: <20171014153828.GS8833@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 12:43:00PM +0200, Lothar Wa?mann wrote:
> Convert the TXUL board support to use the panel-simple driver.
> The now obsolete 'display-timings' node is kept for compatibility with
> U-Boot, which derives its display configuration therefrom.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

It needs a rebase on imx/dt branch.

Shawn
