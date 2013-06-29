From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 29 Jun 2013 14:14:09 +0200
Subject: [PATCH v3 1/5] rtc: mxc_rtc: Driver rework
In-Reply-To: <1372495244-21215-1-git-send-email-shc_work@mail.ru>
References: <1372495244-21215-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130629121409.GQ516@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander,

On Sat, Jun 29, 2013 at 12:40:40PM +0400, Alexander Shiyan wrote:
> This patch rework mxc_rtc driver.
> Major changes have been made:
> - Added second clock support (optional) which permit module functionality.
> - Implemented support for periodic interrupts.
> - Some code have been optimized.

You won't get any further with this if you don't listen to comments.

We're at v3 and Still this patch combines many totally unrelated changes
in a single patch. This was noted by Shawn and more detailed by myself.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
