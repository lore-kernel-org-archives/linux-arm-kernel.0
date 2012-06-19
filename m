From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Jun 2012 14:14:16 +0800
Subject: [Patch v5 00/13] add imx usb driver for mx28/6x
In-Reply-To: <CAOMZO5DF+CH+qe+VKc4vefkj05aXOtn0nVZK9vx+0kakP_em1A@mail.gmail.com>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <CAOMZO5BXsPtwC2CTt6Z-DjZUYhrWMKDkr2QnFoAKb-aLc1XsNA@mail.gmail.com>
 <201206181913.06886.marex@denx.de>
 <CAOMZO5DF+CH+qe+VKc4vefkj05aXOtn0nVZK9vx+0kakP_em1A@mail.gmail.com>
Message-ID: <20120619061414.GD21951@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 02:25:20PM -0300, Fabio Estevam wrote:
> Nothing shows up in the console after connecting the stick.
> 
> Attached my .config file.
> 
You haven't enabled the following two in your .config.

CONFIG_USB_CHIPIDEA
CONFIG_USB_CHIPIDEA_HOST

-- 
Regards,
Shawn
