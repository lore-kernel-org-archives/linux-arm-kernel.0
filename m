From: balbi@ti.com (Felipe Balbi)
Date: Fri, 2 Oct 2015 11:09:02 -0500
Subject: Queueing b0a688ddcc50 "usb: musb: cppi41: allow it to work
 again" for -stable
In-Reply-To: <CAAEAJfC7z=dvw_5vgXDBWVQdKA5jDpfECYv4Jy67YaT7219uJA@mail.gmail.com>
References: <CAAEAJfC7z=dvw_5vgXDBWVQdKA5jDpfECYv4Jy67YaT7219uJA@mail.gmail.com>
Message-ID: <20151002160902.GF5552@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 02:23:45AM -0300, Ezequiel Garcia wrote:
> Hello,
> 
> Commit b0a688ddcc50 "usb: musb: cppi41: allow it to work again" seems
> to fix a regression. It applies cleanly on v4.1 and removes the
> "musb-hdrc musb-hdrc.1.auto: Need DT for the DMA engine." error.
> 
> Any chance you can queue it for -stable?

Have a look at Documentation/stable_kernel_rules.txt, you can do a proper
request for Greg and he will make sure it gets there.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151002/e913ace5/attachment.sig>
