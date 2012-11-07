From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 7 Nov 2012 15:22:16 +0100
Subject: [PATCH] ARM: mxs: apf28dev: Add I2C, SPI and spidev support
In-Reply-To: <20121107152005.549fa8de@dell>
References: <1352225793-93208-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <509A24D4.9000308@free-electrons.com>
 <20121107152005.549fa8de@dell>
Message-ID: <20121107142215.GC20844@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 03:20:05PM +0100, gwenhael.goavec wrote:

> The APF28dev docking board contains no spi peripheral by default. The spidev
> driver is used to evaluation and fast prototyping of peripherals before creating 
> a driver. Consequently it's a bit difficult to add a compatible string... 
> What is the solution in this situation? 

If you're doing that sort of prototyping and development surely it's
easy to locally edit the DT and/or kernel code to register the device as
part of the development?  The DT is supposed to describe the hardware so
if you're changing the hardware it seems reasonable to change the DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121107/24a99ccf/attachment-0001.sig>
