From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 9 May 2014 14:01:13 +0800
Subject: [PATCH] ARM: dts: i.MX51 babbage: Fix FEC pad ctrl settings
In-Reply-To: <1399529850-20186-1-git-send-email-s.hauer@pengutronix.de>
References: <1399529850-20186-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20140509060111.GE2870@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 08:17:30AM +0200, Sascha Hauer wrote:
> The dts relied on the FEC pad ctrl settings from the bootloader by
> using the NO_PAD_CTRL option. This breaks once the bootloader starts
> initializing the pad ctrl settings from the same dts file. Change
> to real pad ctrl settings taken from the platform based babbage
> support.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied, thanks.
