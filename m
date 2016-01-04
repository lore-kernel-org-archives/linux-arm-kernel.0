From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 4 Jan 2016 18:26:14 +1100
Subject: Including Raspberry Pi -next trees in linux-next
In-Reply-To: <87fuyozzax.fsf@eliezer.anholt.net>
References: <87fuyozzax.fsf@eliezer.anholt.net>
Message-ID: <20160104182614.4be3fa06@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Sat, 26 Dec 2015 13:15:50 -0800 Eric Anholt <eric@anholt.net> wrote:
>
> I'll be sending pull-requests to Florian soon, but I would like to get
> my trees included in linux-next to get increased testing coverage of
> them against everything else going on for 4.5.  I'm expecting to produce
> trees under these branch names for the forseeable future.
> 
> Repo: https://github.com/anholt/linux.git
> 
> branches:
> drm-vc4-next
> bcm2835-dt-next
> bcm2835-soc-next
> bcm2835-drivers-next
> bcm2385-defconfig-next
> (bcm2835-maintainers-next is a placeholder since we have nothing for it
> this round)

I have added the first 5 from today.  Can you tell me which trees they
will be merged via so I can position them in my list correctly,
please?

Also, I was wondering how they relate to the bcm2835 tree I currently
have (git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
for-next) currently maintained by Stephen Warren (cc'd).

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
