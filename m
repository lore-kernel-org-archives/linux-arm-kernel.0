From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Mon, 25 Aug 2014 08:53:20 +0200
Subject: [PATCH 1/6] ARM: dts: microsom-ar8035: MDIO pad must be set
 open drain
In-Reply-To: <20140824095854.GR30401@n2100.arm.linux.org.uk>
References: <20140823091058.GO30401@n2100.arm.linux.org.uk>
 <E1XL7M1-0002yD-K3@rmk-PC.arm.linux.org.uk>
 <53F9B416.5030907@gmail.com>
 <20140824095854.GR30401@n2100.arm.linux.org.uk>
Message-ID: <20140825085320.7b2c0eca@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Le Sun, 24 Aug 2014 10:58:55 +0100,
Russell King - ARM Linux <linux@arm.linux.org.uk> a ?crit :
> For me, the problem device right now is that placing the Vivante 2D
> GPU under stress (using gtkperf) causes the pixel engines to lock up.
> The Solo is extremely unstable, locking up in less than a second on
> the first or second test, whereas the Quad is much better, normally
> taking two runs before locking up in the circle drawing.  The Solo
> also locks up the 2D pixel engines if it needs ot resize the display
> (due to HDMI being connected.)
> 
Maybe the lock you get is related to what this patch is supposed to
fix in Freescale's kernel ?
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/?h=imx_3.10.17_1.0.1_ga&id=ba5139e1daa3f5834b061a099bcec8e85575a2c0

Best regards,
Eric
