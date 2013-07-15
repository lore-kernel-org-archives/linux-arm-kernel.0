From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Jul 2013 23:19:18 +0200
Subject: [PATCH 05/22] ARM: i.MX25 DT: use auxdata to attach
 imxfb_platform_data
In-Reply-To: <1373900227-341-6-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
 <1373900227-341-6-git-send-email-denis@eukrea.com>
Message-ID: <20130715211918.GB10995@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 04:56:50PM +0200, Denis Carikli wrote:
> This commit is based on the following commit:
>   ab2815c3997b179f043a747264d155ab0bc181ad ARM: mxs: use auxdata to attach mxsfb_platform_data
> 

This patch is not necessary. The imxfb driver has proper devicetree
binding since 3.11-rc1.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
