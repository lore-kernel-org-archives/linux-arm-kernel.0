From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 May 2014 07:20:13 +0200
Subject: [PATCH] media: mx1_camera: Remove driver
In-Reply-To: <1399788551-8218-1-git-send-email-shc_work@mail.ru>
References: <1399788551-8218-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140512052013.GA5858@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 11, 2014 at 10:09:11AM +0400, Alexander Shiyan wrote:
> That driver hasn't been really maintained for a long time. It doesn't
> compile in any way, it includes non-existent headers, has no users,
> and marked as "broken" more than year. Due to these factors, mx1_camera
> is now removed from the tree.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

I remember this driver was in the way of further cleanups. We should
remove it.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
