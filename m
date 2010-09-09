From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Thu, 09 Sep 2010 11:40:00 +0300
Subject: [PATCH 1/5] ARM: omap/fb: move omap_init_fb to .init.text
In-Reply-To: <1283414622-2663-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1283408230-22652-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1283414622-2663-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1284021600.13006.16.camel@tubuntu.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 2010-09-02 at 10:03 +0200, ext Uwe Kleine-K?nig wrote:
> omap_init_fb() is only called as arch_initcall and so can live in
> .init.text.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

I picked patches 1, 2 and 3 from this patch set to my tree. They look
fine, thanks!

Patch 4 should probably go through Tony, and 5 was marked
work-in-progress.

 Tomi
