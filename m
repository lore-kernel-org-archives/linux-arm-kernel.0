From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 Mar 2013 10:55:19 +0800
Subject: [PATCH] ARM: mxs: cfa10049: Fix fb initialisation function
In-Reply-To: <1362496415-6986-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1362496415-6986-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130307025517.GC5369@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 04:13:35PM +0100, Maxime Ripard wrote:
> Commit 1fe42740 ("ARM: dts: mxs: Add the LCD to the 10049 board") seem
> to have been applied with some fuzzyness, and the framebuffer
> initialisation code for the CFA-10049 ended up in the CFA-10037
> initialisation function.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks, applied.

Shawn
