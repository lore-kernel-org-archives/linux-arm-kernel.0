From: balbi@ti.com (Felipe Balbi)
Date: Tue, 13 Jan 2015 10:36:54 -0600
Subject: [PATCH 05/11] usb: gadget: at91_udc: Remove non-DT handling code
In-Reply-To: <20150112225330.GQ2447@piout.net>
References: <1417606330-17753-1-git-send-email-boris.brezillon@free-electrons.com>
 <1417606330-17753-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150112213905.GI2858@saruman> <20150112225330.GQ2447@piout.net>
Message-ID: <20150113163654.GI16533@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 12, 2015 at 11:53:30PM +0100, Alexandre Belloni wrote:
> Hi Felipe,
> 
> I've rebased that patch series but it depends on another one (the mfd:
> syscon: part of "memory: add Atmel EBI (External Bus Interface)
> driver") that is not taken yet so applying it now will break the
> build. I still hope to get it merged for 3.20 and I'll resend it as
> soon as possible.

In that case, we either take the entire series through MFD (including
the gadget patches) or we delay the gadget patches until all
dependencies have been sorted out.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/4af46e2e/attachment.sig>
