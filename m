From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 9 Aug 2016 14:02:29 +0800
Subject: [PATCH] ARM: mxs: remove obsolete startup code for TX28
In-Reply-To: <1468239528-10501-1-git-send-email-LW@KARO-electronics.de>
References: <1468239528-10501-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20160809060229.GM4678@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 02:18:48PM +0200, Lothar Wa?mann wrote:
> The power and reset handling of the FEC ethernet driver is sufficient
> to get the ethernet PHY on the TX28 into a usable state.
> Remove the code that does the PHY initialization on startup.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Applied, thanks.
