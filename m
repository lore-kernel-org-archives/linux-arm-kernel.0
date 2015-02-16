From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 16 Feb 2015 06:47:02 +0100
Subject: [PATCH] i.MX6: WEIM: put node reference on early loop exit
In-Reply-To: <1423848784-6988-1-git-send-email-alison_chaiken@mentor.com>
References: <1423848784-6988-1-git-send-email-alison_chaiken@mentor.com>
Message-ID: <20150216054702.GF12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 09:33:04AM -0800, alison at she-devel.com wrote:
> From: Alison Chaiken <alison_chaiken@mentor.com>
> 
> Signed-off-by: Alison Chaiken <alison_chaiken@mentor.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Looking at the code I get the question why the current code bails out on
error. Wouldn't it be better to just skip erroneous child devices and
issue a warning?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
