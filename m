From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 28 Feb 2016 11:13:10 +0800
Subject: [PATCH bugfix] ARM: dts: imx51: remove bogus pin definition
In-Reply-To: <1456495732-3233-1-git-send-email-LW@KARO-electronics.de>
References: <1456495732-3233-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20160228031310.GE22051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 03:08:52PM +0100, Lothar Wa?mann wrote:
> Pad DISPB2_SER_RS has no function DISP1_EXT_CLK.
> The definition is obviusly a copy/paste error from
> MX51_PAD_DISPB2_SER_RS__DISP1_PIN16.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Applied, thanks.
