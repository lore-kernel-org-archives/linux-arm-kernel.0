From: balbi@ti.com (Felipe Balbi)
Date: Mon, 12 Jan 2015 12:23:49 -0600
Subject: [PATCH v3 3/5] ARM: at91/dt: update udc compatible strings
In-Reply-To: <1421060278-27329-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1421060278-27329-1-git-send-email-boris.brezillon@free-electrons.com>
 <1421060278-27329-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150112182349.GJ6525@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 11:57:56AM +0100, Boris Brezillon wrote:
> at91sam9g45, at91sam9x5 and sama5 SoCs should not use
> "atmel,at91sam9rl-udc" for their USB device compatible property since
> this compatible is attached to a specific hardware bug fix.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

WARNING: DT compatible string "atmel,at91sam9g45-udc" appears un-documented -- check ./Documentation/devicetree/bindings/
#177: FILE: drivers/usb/gadget/udc/atmel_usba_udc.c:1827:
+       { .compatible = "atmel,at91sam9g45-udc" },

WARNING: DT compatible string "atmel,sama5d3-udc" appears un-documented -- check ./Documentation/devicetree/bindings/
#178: FILE: drivers/usb/gadget/udc/atmel_usba_udc.c:1828:
+       { .compatible = "atmel,sama5d3-udc" },

please fix and resend. Also, when resending, could you add Nicolas'
Acked-by since he's already given it ?

Thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150112/b2cccec7/attachment-0001.sig>
