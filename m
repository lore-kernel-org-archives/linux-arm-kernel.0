From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 25 Jul 2013 18:33:44 -0500
Subject: [PATCH 02/12] ARM: ep93xx: vision_ep9307: Use MMC CD and RO GPIO
In-Reply-To: <1374794808-21890-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1374794808-21890-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DAC5C20A6@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 25, 2013 4:27 PM, Laurent Pinchart wrote:
>
> Pass the CD and RO GPIO numbers to the MMC SPI driver and remove the
> custom .get_cd() and .get_ro() callback functions.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/mach-ep93xx/vision_ep9307.c | 56 +++---------------------------------
>  1 file changed, 4 insertions(+), 52 deletions(-)

I'll try testing this tomorrow.

Thanks,
Hartley
