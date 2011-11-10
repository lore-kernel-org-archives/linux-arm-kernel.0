From: balbi@ti.com (Felipe Balbi)
Date: Thu, 10 Nov 2011 22:10:02 +0200
Subject: [PATCH v5 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <f29b091aaf5165d602f7ddd3980de748c1c27688.1320934707.git.n.voss@weinmann.de>
References: <cover.1320934086.git.n.voss@weinmann.de>
 <f29b091aaf5165d602f7ddd3980de748c1c27688.1320934707.git.n.voss@weinmann.de>
Message-ID: <20111110201000.GB17468@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 11:49:46AM +0100, Nikolaus Voss wrote:
> This driver has the following properties compared to the old driver:
> 1. Support for multiple interfaces.
> 2. Interrupt driven I/O as opposed to polling/busy waiting.
> 3. Support for _one_ repeated start (Sr) condition, which is enough
>    for most real-world applications including all SMBus transfer types.
>    (The hardware does not support issuing arbitrary Sr conditions on the
>     bus.)
> 
> Tested on Atmel G45 with BQ20Z80 battery SMBus client.
> 
> Signed-off-by: Nikolaus Voss <n.voss@weinmann.de>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111110/fdf1b885/attachment.sig>
