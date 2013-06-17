From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Jun 2013 09:58:57 +0200
Subject: [PATCH v4] irqchip: renesas-intc-irqpin: DT binding for sense
 bitfield width
In-Reply-To: <Pine.LNX.4.64.1306131121230.31976@axis700.grange>
References: <Pine.LNX.4.64.1306131121230.31976@axis700.grange>
Message-ID: <201306170958.57844.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 June 2013, Guennadi Liakhovetski wrote:
> Most Renesas irqpin controllers have 4-bit sense fields, however, some
> have different widths. This patch adds a DT binding to optionally
> specify such non-standard values.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
