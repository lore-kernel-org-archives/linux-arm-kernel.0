From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 1 Apr 2015 09:35:32 +1100
Subject: at91 git tree in linux-next
In-Reply-To: <551A9FAC.2010203@atmel.com>
References: <551A9FAC.2010203@atmel.com>
Message-ID: <20150401093532.173df258@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Tue, 31 Mar 2015 15:22:52 +0200 Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
>
> I am the maintainer for the Atmel ARM SoCs (aka at91) and I would like to
> know if it's possible for you to include my git tree in linux-next. It is
> usually pulled in by the ARM-soc guys (in copy).
> 
> Here it is, with the branch that you would pull: "at91-next".
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git  at91-next
> 
> I usually merge branches in this particular one when I send a pull-request to
> Arnd, Olof and Kevin so the material is usually pretty "stable".

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window. 

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell 
sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150401/cbac310f/attachment.sig>
