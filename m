From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Apr 2012 21:28:14 +0800
Subject: [PATCH v6 16/17] pwm-backlight: Add rudimentary device tree
 support
In-Reply-To: <1334070400-25013-17-git-send-email-thierry.reding@avionic-design.de>
References: <1334070400-25013-1-git-send-email-thierry.reding@avionic-design.de>
 <1334070400-25013-17-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120411132810.GD2445@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 05:06:39PM +0200, Thierry Reding wrote:
> This commit adds very basic support for device tree probing. Currently,
> only a PWM and a list of distinct brightness levels can be specified.
> Enabling or disabling backlight power via GPIOs is not yet supported.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

[Tested on mach-mxs]
