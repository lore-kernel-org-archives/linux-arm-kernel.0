From: balbi@ti.com (Felipe Balbi)
Date: Fri, 11 Oct 2013 11:05:28 -0500
Subject: [PATCH v4 01/17] ARM: at91: move at91_pmc.h to
 include/linux/clk/at91_pmc.h
In-Reply-To: <1381477081-6041-2-git-send-email-b.brezillon@overkiz.com>
References: <1381477081-6041-1-git-send-email-b.brezillon@overkiz.com>
 <1381477081-6041-2-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20131011160528.GV25706@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 09:37:45AM +0200, Boris BREZILLON wrote:
> This patch moves at91_pmc.h header from machine specific directory
> (arch/arm/mach-at91/include/mach/at91_pmc.h) to clk include directory
> (include/linux/clk/at91_pmc.h).
> We need this to avoid reference to machine specific headers in clk
> drivers.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

for drivers/usb/gadget:

Acked-by: Felipe Balbi <balbi@ti.com>


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131011/56b63bc7/attachment.sig>
