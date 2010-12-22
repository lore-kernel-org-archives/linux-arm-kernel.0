From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Dec 2010 17:54:04 -0800
Subject: [PATCH v2] OMAP2: Devkit8000: Use _cansleep GPIO functions for
	display reset lines
In-Reply-To: <1292926993.9611.10.camel@morsing>
References: <1292926993.9611.10.camel@morsing>
Message-ID: <20101222015404.GO5829@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Daniel Morsing <daniel.morsing@gmail.com> [101221 02:22]:
> The display reset lines are connected to a TPS65930 which may sleep
> when changing GPIO values. Use the appropriate function to silence
> a nasty warning from gpiolib.
> 
> Signed-off-by: Daniel Morsing <daniel.morsing@gmail.com>
> Acked-by: Thomas Weber <weber@corscience.de>

Thanks applying.

Tony
