From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Jun 2013 15:29:30 +1000
Subject: linux-next: manual merge of the arm-soc tree with the mailbox tree
In-Reply-To: <51C4703C.10206@ti.com>
References: <20130621162656.bb94e0fa8b6813781b804a73@canb.auug.org.au>
 <CAOesGMjszju75jo6Ej6C=0-rfdPLuEj0mwmU1zYvFvYw1dyQCA@mail.gmail.com>
 <20130621071239.GM5523@atomide.com>
 <201306210936.09593.arnd@arndb.de> <51C4703C.10206@ti.com>
Message-ID: <20130624152930.4c6cef3c5a272d8ca82d94c6@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 21 Jun 2013 10:24:44 -0500 Suman Anna <s-anna@ti.com> wrote:
>
> On 06/21/2013 02:36 AM, Arnd Bergmann wrote:
> > On Friday 21 June 2013, Tony Lindgren wrote:
> >>> I wonder if this mess is caused by the fact that I did the revert
> >>> instead of rebuilding our for-next and dropping the merge in the first
> >>> place.
> >>>
> >>> I'll rebuild our for-next (or maybe Arnd will beat me to it) before
> >>> next linux-next build, i.e. Sunday night my time.
> >>
> >> Could be, especially if some of the commits are the same in the reverted
> >> branch and newly merged branch as git might think that some merges have
> >> been already resolved the right way earlier.
> 
> Yes, please drop the particular mailbox branch that you were picking
> into linux-next. It was the previous framework which was dropped at the
> last minute during the 3.10 merge window in favor of new one still under
> its final development steps, so we will not be using any commits from
> that branch.  Sorry for the trouble on this one. The branch that Arnd
> took has some of the OMAP patches reworked in preparation for the
> newer one.

OK, I have removed the mailbox tree for now.  Let me know if you want it
to be back in again.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130624/90808085/attachment-0001.sig>
