From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 8 Dec 2013 12:54:08 -0500
Subject: [PATCH] ARM: DT: Dove: Use symbolic names from gpio.h
In-Reply-To: <1386517687-28820-1-git-send-email-andrew@lunn.ch>
References: <1386517687-28820-1-git-send-email-andrew@lunn.ch>
Message-ID: <20131208175408.GL11251@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 08, 2013 at 04:48:07PM +0100, Andrew Lunn wrote:
> Replace 0 and 1 with GPIO_ACTIVE_HIGH, GPIO_ACTIVE_LOW
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/dove-cubox.dts  |  8 ++++----
>  arch/arm/boot/dts/dove-d2plug.dts |  6 +++---
>  arch/arm/boot/dts/dove-d3plug.dts | 12 ++++++------
>  arch/arm/boot/dts/dove.dtsi       |  1 +
>  4 files changed, 14 insertions(+), 13 deletions(-)

Applied to mvebu/dt

thx,

Jason.
