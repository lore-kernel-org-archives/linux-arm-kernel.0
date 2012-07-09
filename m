From: marex@denx.de (Marek Vasut)
Date: Mon, 9 Jul 2012 10:50:31 +0200
Subject: [PATCH 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <20120709084032.GF11635@S2101-09.ap.freescale.net>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <201207091018.25979.marex@denx.de>
 <20120709084032.GF11635@S2101-09.ap.freescale.net>
Message-ID: <201207091050.31528.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

[...]

Shouldn't MACH_MXS_DT now select MXS_OCOTP ? It kinda doesn't compile without 
it.

Best regards,
Marek Vasut
