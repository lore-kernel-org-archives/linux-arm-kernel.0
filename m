From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 4 Feb 2011 11:39:42 -0600
Subject: [PATCH] ep93xx: correct the end address of the AC97 memory
	resource
In-Reply-To: <1296840895-21410-1-git-send-email-mika.westerberg@iki.fi>
References: <1296840895-21410-1-git-send-email-mika.westerberg@iki.fi>
Message-ID: <0D753D10438DA54287A00B027084269764CF0C45E3@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 04, 2011 10:35 AM, Mika Westerberg wrote:
>
> The last register is at offset 0xa8 making the resource end to be 0xac - 1
> instead of 0xb0 - 1.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>

Verified.  Thanks for fixing this.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
