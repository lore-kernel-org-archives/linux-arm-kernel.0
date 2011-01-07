From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 7 Jan 2011 14:49:25 -0600
Subject: [PATCH] ARM: aaec2000: remove support for mach-aaec2000
In-Reply-To: <1294430422-939-1-git-send-email-jamie@jamieiles.com>
References: <1294430422-939-1-git-send-email-jamie@jamieiles.com>
Message-ID: <0D753D10438DA54287A00B027084269764C4123E68@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, January 07, 2011 1:00 PM, Jamie Iles wrote:
>
> mach-aaec2000 is no longer actively maintained and is only receiving
> fixups to remain building with other kernel updates.

What about the MACH_AAED2000 specific drivers?  The only one I see is:

drivers/input/keyboard/aaed2000_kbd.c

Regards,
Hartley
