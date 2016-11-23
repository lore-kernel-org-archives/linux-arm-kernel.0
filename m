From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Nov 2016 09:03:50 +0100
Subject: [PATCH] ARM: dts: sunxi: Enable UEXT related nodes for Olimex
 A20 SOM EVB
In-Reply-To: <20161121164911.76900-1-manu@bidouilliste.com>
References: <20161121164911.76900-1-manu@bidouilliste.com>
Message-ID: <20161123080350.fstwdfndghk7c5xx@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 05:49:11PM +0100, Emmanuel Vadot wrote:
> UEXT are Universal EXTension connector from Olimex. They embed i2c, spi
> and uart pins along power in one connector and are found on most,
> if not all, Olimex boards.
> The Olimex A20 SOM EVB have two UEXT connector so enable the nodes found on
> those two connectors.
> 
> Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>

Fixed the indentation of the spi pinctrl cells, and applied.

Please note that I'm note planning to send any new pull request, so
this will likely end up in 4.11.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161123/ada4f4d4/attachment-0001.sig>
