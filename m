From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 26 Mar 2015 11:10:55 +1100
Subject: Request for additional arm64 branch in linux-next
In-Reply-To: <20150325172002.GN24636@arm.com>
References: <20150325172002.GN24636@arm.com>
Message-ID: <20150326111055.273aa644@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wed, 25 Mar 2015 17:20:03 +0000 Will Deacon <will.deacon@arm.com> wrote:
>
> We've got a series of patches introducing ACPI support for arm64 that
> are tentatively targetting the 4.1 merge window. Whilst there are
> face-to-face discussions set to happen in the next day or so around this
> topic, could you please pull this into linux-next under the assumption
> that we decide to go ahead for mainline inclusion?
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/acpi
> 
> I've kept the series separate from the usual arm64 branch (for-next/core)
> but they merge without conflicts. Merging with today's next, I see two
> trivial Kconfig conflicts (resolution below).

Added from today (and thanks for the hints).  Will this be merged via
another tree, or go directly to Linus?

> I'll let you know when the branch is no longer needed.

Excellent.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150326/9a4a128c/attachment.sig>
