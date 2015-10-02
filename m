From: balbi@ti.com (Felipe Balbi)
Date: Fri, 2 Oct 2015 12:24:08 -0500
Subject: Queueing b0a688ddcc50 "usb: musb: cppi41: allow it to work
 again" for -stable
In-Reply-To: <CAAEAJfALjV2BCJwzd20TQA3CWa1VZRM5vPv6CydrBuMJc=vVAw@mail.gmail.com>
References: <CAAEAJfC7z=dvw_5vgXDBWVQdKA5jDpfECYv4Jy67YaT7219uJA@mail.gmail.com>
 <20151002160902.GF5552@saruman.tx.rr.com>
 <CAAEAJfALjV2BCJwzd20TQA3CWa1VZRM5vPv6CydrBuMJc=vVAw@mail.gmail.com>
Message-ID: <20151002172408.GJ5552@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 02:16:50PM -0300, Ezequiel Garcia wrote:
> On 2 October 2015 at 13:09, Felipe Balbi <balbi@ti.com> wrote:
> > On Fri, Oct 02, 2015 at 02:23:45AM -0300, Ezequiel Garcia wrote:
> >> Hello,
> >>
> >> Commit b0a688ddcc50 "usb: musb: cppi41: allow it to work again" seems
> >> to fix a regression. It applies cleanly on v4.1 and removes the
> >> "musb-hdrc musb-hdrc.1.auto: Need DT for the DMA engine." error.
> >>
> >> Any chance you can queue it for -stable?
> >
> > Have a look at Documentation/stable_kernel_rules.txt, you can do a proper
> > request for Greg and he will make sure it gets there.
> >
> 
> Sure, I will.
> 
> Maybe next time you could add a Cc: stable to these kinds of fixes, along with
> a proper Fixes tag, so the -stable folks can pick them automatically.

I usually do, in this case, nobody had complained about this board in any stable
kernel so I just didn't.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151002/4bb1683c/attachment.sig>
