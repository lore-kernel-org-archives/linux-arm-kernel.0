From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 6 Jun 2016 01:00:07 +1000
Subject: linux-next: request to include linux-amlogic tree
In-Reply-To: <CAOi56cXb7TjsctpeFWqGCmEx2LG-i11qoLBGDhi1OBJpbyko4A@mail.gmail.com>
References: <CAOi56cXb7TjsctpeFWqGCmEx2LG-i11qoLBGDhi1OBJpbyko4A@mail.gmail.com>
Message-ID: <20160606010007.6941cc2d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Fri, 3 Jun 2016 14:49:01 -0700 Kevin Hilman <khilman@baylibre.com> wrote:
>
> Please add the following tree/branch to linux-next.  This is used for
> the kernel development of the ARM-based Amlogic SoCs:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git
> for-next

Added from today.  I assume that this will be merged via the arm-soc
tree?  I also have just you as the contact - I can add more contacts if
that makes sense.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
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
