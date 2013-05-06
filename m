From: broonie@kernel.org (Mark Brown)
Date: Mon, 6 May 2013 11:29:57 +0100
Subject: [RFT][PATCH 1/2] clk: wm831x: Fix update wrong register for
 enable/disable FLL
In-Reply-To: <1367422261.8160.1.camel@phoenix>
References: <1367422261.8160.1.camel@phoenix>
Message-ID: <20130506102957.GA13472@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 01, 2013 at 11:31:01PM +0800, Axel Lin wrote:
> According to the datasheet, FLL Enable is controlled by
> R16530 (4092h) FLL Control1

Both

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130506/9a94a8a2/attachment.sig>
