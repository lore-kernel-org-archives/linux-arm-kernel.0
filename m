From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 10 Nov 2011 09:03:31 +0100
Subject: [PATCH 1/9] ARM: mxc: time: convert to clk_prepare/clk_unprepare
In-Reply-To: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
References: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111110080331.GS16886@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

I think we should introduce two new helpers:

clk_prepare_enable()
clk_disable_unprepare()

This series could look much nicer with it.

Minor nitpick: I don't like the subject. 'convert' suggests that you are
replacing something, instead you are adding something.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
