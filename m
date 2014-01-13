From: marex@denx.de (Marek Vasut)
Date: Mon, 13 Jan 2014 12:43:57 +0100
Subject: [PATCH] imx-drm: parallel-display: honor 'native-mode' property
 when selecting video mode from DT
In-Reply-To: <1389608673-10565-1-git-send-email-LW@KARO-electronics.de>
References: <1389608673-10565-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <201401131243.57573.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 13, 2014 at 11:24:33 AM, Lothar Wa?mann wrote:
> This patch allows to select a specific video mode from a list of modes
> defined in DT by setting the 'native-mode' property appropriately.
> 
> Since all current users of this driver have only one mode defined in
> their .dts files, the patch does not change the behaviour of this
> driver on the affected platforms.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Looks OK to me, thanks.

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
