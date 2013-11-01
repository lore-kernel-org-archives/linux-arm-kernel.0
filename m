From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 1 Nov 2013 17:14:50 +0800
Subject: [PATCH] ARM: imx6q: add missing sentinel to divider table
In-Reply-To: <1383220548-8622-1-git-send-email-LW@KARO-electronics.de>
References: <1383220548-8622-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20131101091449.GD10324@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 12:55:48PM +0100, Lothar Wa?mann wrote:
> The clk_enet_ref_table[] is missing a final empty entry as end of list
> marker. Also make the existing markers more obvious.
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Please have a blank line between commit log and SoB in the later
patches.

Applied, thanks.
