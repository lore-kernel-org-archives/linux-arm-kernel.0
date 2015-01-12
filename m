From: balbi@ti.com (Felipe Balbi)
Date: Mon, 12 Jan 2015 15:39:05 -0600
Subject: [PATCH 05/11] usb: gadget: at91_udc: Remove non-DT handling code
In-Reply-To: <1417606330-17753-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1417606330-17753-1-git-send-email-boris.brezillon@free-electrons.com>
 <1417606330-17753-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150112213905.GI2858@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 12:32:04PM +0100, Boris Brezillon wrote:
> Since non-DT board support has been removed from the at91 architecture we
> can safely remove non-DT handling code.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

doesn't apply cleanly:

checking file drivers/usb/gadget/udc/Kconfig
checking file drivers/usb/gadget/udc/at91_udc.c
Hunk #1 succeeded at 1710 (offset 13 lines).
Hunk #2 succeeded at 1722 (offset 13 lines).
Hunk #3 succeeded at 1958 (offset 13 lines).
Hunk #4 FAILED at 1960.
1 out of 4 hunks FAILED

please rebase on testing/next which I just pushed.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150112/ba1fcf55/attachment.sig>
