From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 21 Apr 2011 12:33:01 -0500
Subject: [PATCH v2 23/23] at91: Remove mAgic and ISI device code
In-Reply-To: <1303364535-11557-24-git-send-email-ryan@bluewatersys.com>
References: <1303364535-11557-1-git-send-email-ryan@bluewatersys.com>
	<1303364535-11557-24-git-send-email-ryan@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B027084269764D242FC6C@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 20, 2011 10:42 PM, Ryan Mallon wrote:
>
> The AT572D940HF mAgic device and the AT91SAM9263 ISI device do not
> have drivers yet and therefore the platform code in arch/arm/mach-at91
> is unused and can be removed.

Is anyone planning on adding these drivers?

I wonder if it makes sense to add the infrastructure to devices.[ch] and
convert the users even it the drivers are not in mainline yet?

Regards,
Hartley
