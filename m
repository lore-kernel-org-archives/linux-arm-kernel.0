From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 27 Mar 2013 09:34:50 +0100
Subject: [PATCH 0/2] ARM: shmobile: marzen: defconfig updates for v3.10
In-Reply-To: <1364356017-25890-1-git-send-email-horms+renesas@verge.net.au>
References: <1364356017-25890-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <2124307.JaW9GEbPEK@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thanks for the patches.

On Wednesday 27 March 2013 12:46:55 Simon Horman wrote:
> Hi,
> 
> the this short series updates the defconfig for marzen for changes
> made by the following patches which I plan to queue-up for v3.10 shortly.
> 
> 1. ARM: shmobile: marzen: Add GPIO LEDs
> 2. gpio: Renesas R-Car GPIO driver V3
> 
> The patches in this series are:
> 
> Simon Horman (2):
>   ARM: shmobile: marzen: defconfig: add GPIO RCAR driver support
>   ARM: shmobile: marzen: defconfig: enable GPIO LEDs driver
> 
>  arch/arm/configs/marzen_defconfig |    4 ++++
>  1 file changed, 4 insertions(+)

For the whole series,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
