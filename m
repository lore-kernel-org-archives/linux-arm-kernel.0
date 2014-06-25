From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Jun 2014 08:20:09 +0200
Subject: [PATCH v2 1/2] ARM: dts: i.MX25: Fix gpt timers clocks.
In-Reply-To: <1403529927-13868-1-git-send-email-denis@eukrea.com>
References: <1403529927-13868-1-git-send-email-denis@eukrea.com>
Message-ID: <20140625062009.GG15686@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 03:25:26PM +0200, Denis Carikli wrote:
> Without that fix, the board freeze during boot.
> 
> This appeared after the following commit:
>   496f065 ARM: i.MX: Use of_clk_get_by_name() for timer clocks for DT case.
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>


Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
