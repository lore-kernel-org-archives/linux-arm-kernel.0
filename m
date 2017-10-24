From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Oct 2017 14:24:45 +0800
Subject: [PATCH] ARM: dts: imx53-tx53: fix interrupt flags
In-Reply-To: <1508770600-28496-1-git-send-email-LW@KARO-electronics.de>
References: <1508770600-28496-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20171024062444.GB6403@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 04:56:40PM +0200, Lothar Wa?mann wrote:
> Some interrupts properties are given '0' as the flags argument or no
> flags argument at all.
> Change them to use the appropriate interrupt flags.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Applied, thanks.
