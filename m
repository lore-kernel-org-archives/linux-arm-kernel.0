From: balbi@ti.com (Felipe Balbi)
Date: Thu, 7 Feb 2013 10:39:46 +0200
Subject: [PATCH 0/2] ARM: dts: Add DT bindings for OMAP SDMA
In-Reply-To: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
References: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
Message-ID: <20130207083946.GB15462@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 03:03:14PM -0600, Jon Hunter wrote:
> Adds device-tree bindings from SDMA on OMAP2+ devices. DMA client
> bindings are also added for devices that have SPI and MMC bindings
> populated. Client binding data is based upon existing HWMOD data for
> OMAP and has been checked against OMAP documentation.
> 
> Testing includes ...
> 1. Boot tested on OMAP3430 Beagle board, OMAP4430 Panda board and
>    OMAP4460 Panda board with and without device-tree present.
> 2. Testing of MMC1 with SD card on OMAP3430 Beagle board, OMAP4430
>    Panda board and OMAP4460 Panda board with and without device-tree
>    present.

looks alright to me:

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130207/0b15cb2a/attachment.sig>
