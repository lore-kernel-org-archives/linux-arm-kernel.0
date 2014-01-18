From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 18 Jan 2014 16:27:05 +0800
Subject: [PATCHv2 0/2] ARM: dts: imx53: add support for Ka-Ro TX53 modules
In-Reply-To: <1389860123-14874-1-git-send-email-LW@KARO-electronics.de>
References: <1389860123-14874-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140118082703.GA3430@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 09:15:21AM +0100, Lothar Wa?mann wrote:
> This patch adds support for the Ka-Ro electronics GmbH TX53 modules.
> There are two distinct module types. One with an LVDS display
> interface and SATA support, the other with a parallel LCD
> interface and no SATA interface.
> 
> Changes wrt. v1:
> - set the '#pwm-cells' property locally due to the changed
>   pwm-polarity patch that made this property optional.
>   see <1389859585-14006-3-git-send-email-LW@KARO-electronics.de>

Applied both, thanks.

But please be aware that componentised device adoption required by
moving imx-drm out of staging tree will need some additional change.
Let's fixed it up when it comes.

Shawn
