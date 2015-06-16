From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Jun 2015 21:09:52 -0600
Subject: [PATCH v2 3/3] ARM: dts: bcm2835-rpi: Add "brcm,
 raspberrypi-pm-wdt" to wdt compatible
In-Reply-To: <1434195541-28368-3-git-send-email-noralf@tronnes.org>
References: <1434195541-28368-1-git-send-email-noralf@tronnes.org>
 <1434195541-28368-3-git-send-email-noralf@tronnes.org>
Message-ID: <557F9380.1000607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2015 05:39 AM, Noralf Tr?nnes wrote:
> The Raspberry Pi uses a new value for halt in the PM_RSTS watchdog
> register. Expand the compatible string to cover this.

FWIW, the series,
Tested-by: Stephen Warren <swarren@wwwdotorg.org>

... but that doesn't imply my ack for the patches.
