From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 24 Jun 2014 10:51:58 +1000
Subject: Request for Inclusion in linux-next
In-Reply-To: <20140623211500.GA22471@lukather>
References: <20140623211500.GA22471@lukather>
Message-ID: <20140624105158.34c634d5@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Mon, 23 Jun 2014 23:15:00 +0200 Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
>
> Would it be possible to add the sunxi tree for linux-next coverage.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git, branch sunxi/for-next
> 
> It will be based on Linus' tree.

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
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140624/35295dc0/attachment.sig>
