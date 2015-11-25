From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 25 Nov 2015 10:59:52 +0800
Subject: [PATCH 1/2] ARM: dts: imx: ventana: add PWM nodes for Ventana
 boards
In-Reply-To: <1447963323-21919-1-git-send-email-tharvey@gateworks.com>
References: <1447963323-21919-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20151125025952.GC11999@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 12:02:03PM -0800, Tim Harvey wrote:
> Ventana boards have an off-board connector with signals that can be pinmuxed
> as either GPIO or PWM. This patch adds pwm device-tree nodes in the disabled
> state which the bootloader can decide to enable based on bootloader config.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Tim,

Please use my kernel.org rather than linaro.org mail address in the
future.  The MAINTAINERS file had been updated for a few release cycles.

Shawn
