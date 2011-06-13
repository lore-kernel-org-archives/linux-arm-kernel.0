From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 13 Jun 2011 12:39:53 -0500
Subject: [PATCH v2 1/5] ARM: ep93xx: use more reliable CPLD watchdog for
	reset	on ts72xx
In-Reply-To: <1307891100-31123-2-git-send-email-ynezz@true.cz>
References: <1307891100-31123-1-git-send-email-ynezz@true.cz>
	<1307891100-31123-2-git-send-email-ynezz@true.cz>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3821F5A05@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, June 12, 2011 8:05 AM, Petr ?tetiar wrote:
>
> On all ep93xx based boards from Technologic Systems, there's CPLD watchdog
> available, so use this one to reset the board instead of the soft reset in
> CPU.  I've seen some weird lockups with the soft reset on ep93xx in the past,
> while the reset via CPLD watchdog seems to be rock solid (tm) and works fine
> so far.
>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> Tested-by: Mika Westerberg <mika.westerberg@iki.fi>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Signed-off-by: Petr ?tetiar <ynezz@true.cz>

Please submit to Russell's Patch Tracker.

Regards,
Hartley
