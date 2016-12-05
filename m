From: stefan@agner.ch (Stefan Agner)
Date: Mon, 05 Dec 2016 12:29:39 -0800
Subject: [PATCH] ARM: dts: imx7d: fix LCDIF clock assignment
In-Reply-To: <20161205070609.a6t7hzh3m3l2t37s@pengutronix.de>
References: <20161123004204.10851-1-stefan@agner.ch>
 <CAOMZO5AqKupmmKb4biGfmy4v3ZwS-BFjPY=MLd8Rc0ZXL+vQvg@mail.gmail.com>
 <7e4829f484f6c4425fc9d01bea1a094f@agner.ch>
 <20161205070609.a6t7hzh3m3l2t37s@pengutronix.de>
Message-ID: <533232ee44a8807c42cbd060fac75273@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-12-04 23:06, Uwe Kleine-K?nig wrote:
> Hello Stefan,
> 
> On Sun, Dec 04, 2016 at 05:26:58PM -0800, Stefan Agner wrote:
>> Since this fixes a kernel freeze, is there a chance to get this still in
>> 4.9?
> 
> a Fixes:-Line would be nice then.

Good point.

Fixes: e8ed73f691bd ("ARM: dts: imx7d: add lcdif support")

--
Stefan
