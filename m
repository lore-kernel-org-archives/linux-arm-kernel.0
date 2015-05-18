From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 18 May 2015 16:11:20 +0200
Subject: [PATCH v3] clk: mediatek: Initialize clk_init_data
In-Reply-To: <1431957632-2182-1-git-send-email-jcliang@chromium.org>
References: <1431957632-2182-1-git-send-email-jcliang@chromium.org>
Message-ID: <20150518141120.GU6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 10:00:26PM +0800, Ricky Liang wrote:
> The variable init (struct clk_init_data) is allocated on the stack.
> We weren't initializing the .flags field, so it contains random junk,
> which can cause all kinds of interesting issues when the flags are
> parsed by clk_register.
> 
> Signed-off-by: Ricky Liang <jcliang@chromium.org>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
