From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 7 Mar 2016 17:03:53 -0300
Subject: [PATCH 0/3] video: fbdev: imxfb: make it work again
In-Reply-To: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAOMZO5BxrVHNq8BdOqAqkaOqC905+AOSkFtsrWFHbz4cfN=Kaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Mon, Mar 7, 2016 at 4:53 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> it seems the imxfb driver stopped working quite some time ago. Here come

Yes, I noticed it has been broken for a long time.

After this fix I managed to get it working again:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/video/fbdev/imxfb.c?id=b82fe6ddd782f847332aeabf8cab980852f61629
