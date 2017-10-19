From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Thu, 19 Oct 2017 10:55:24 +0300
Subject: [PATCH v2] ARM: dts: imx: add ZII RDU1 board
In-Reply-To: <20171018172618.11318-1-l.stach@pengutronix.de>
References: <20171018172618.11318-1-l.stach@pengutronix.de>
Message-ID: <a3da6c54-254f-9174-bfb8-d81b3ef44b58@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This adds support for the Zodiac Inflight Innovations RDU1 board,
> which is based on the i.MX51.
> 
> It is the predecessor of the already supported ZII RDU2 board and
> relies on the bootloader in the same way to enable correct display
> and touchscreen nodes.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Tested-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Board boots ok. DSA works. Display works.
