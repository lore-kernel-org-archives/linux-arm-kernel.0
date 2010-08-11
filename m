From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 11 Aug 2010 18:38:28 +0300
Subject: [PATCH v3 9/9] omap: zoom: add mmc3/wl1271 device support
In-Reply-To: <4C6266FE.5000904@nokia.com>
References: <1281478348-24833-1-git-send-email-ohad@wizery.com>
	<1281478348-24833-10-git-send-email-ohad@wizery.com>
	<4C626140.3080107@nokia.com> <4C6266FE.5000904@nokia.com>
Message-ID: <AANLkTikfq+xJ9jNGorvonJur2zOGvkSsu9SePXr4mw-O@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 12:01 PM, Roger Quadros <roger.quadros@nokia.com> wrote:
> Also shouldn't .nonremovable be set to true? as this is a non-removable card
> slot.

This doesn't seem to have any effect on SDIO, but it can't hurt.

Thanks!


>
> regards,
> -roger
>
