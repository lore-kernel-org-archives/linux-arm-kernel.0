From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 16 Oct 2012 10:08:43 +1100
Subject: new branch for linux-next [Was: [PATCH v6 0/3] Updated
 Cortex-M3 series]
In-Reply-To: <20121008154325.GF18531@pengutronix.de>
References: <1343988614-5508-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20121008154325.GF18531@pengutronix.de>
Message-ID: <20121016100843.c2eba67863ec7b593a489abb@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Mon, 8 Oct 2012 17:43:25 +0200 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
>
> I already tried several times to get feedback from Russell King (as you
> probably know he's the ARM maintainer and busy most of the time) for my
> series to support Cortex-M3 machines. As I think the outcome will
> probably (at least) be that it should be included in next for some time
> first (as for example Arnd Bergmann already suggested), can you please
> add
> 
> 	git://git.pengutronix.de/git/ukl/linux-2.6.git for-next
> 
> to your tree? I'd suggest adding it after arm and arm-soc.
> I intend to use this branch later for efm32 support (which depends on
> the Cortex-M3 stuff).
> 
> Currently the branch is still empty, but I intend to fill it with what I
> consider to be applyable after I did some more testing. (Mainly to
> assert it still does what it did when I developed it on an older base.)
> 
> @Russell: I hope this is OK for you. If not, I'm sure you'll protest.

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

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121016/e15a9a13/attachment.sig>
