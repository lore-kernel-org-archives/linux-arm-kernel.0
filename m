From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Sep 2015 08:36:34 +0200
Subject: [PATCH 0/2] mtd: nand: sunxi: cleanup
In-Reply-To: <20150929222144.GA143959@google.com>
References: <1442389597-30698-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150929222144.GA143959@google.com>
Message-ID: <20150930083634.68351ade@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Tue, 29 Sep 2015 15:21:44 -0700
Brian Norris <computersforpeace@gmail.com> wrote:

> On Wed, Sep 16, 2015 at 09:46:35AM +0200, Boris Brezillon wrote:
> > Hello,
> > 
> > Those two patches aim at cleaning up the sunxi_nand driver by first adding
> > some consistency in the macro definitions, and then factorizing the code
> > duplicated code found in hw_ecc and hw_syndrome_ecc implementations.
> > 
> > Best Regards,
> > 
> > Boris
> 
> I believe this series no longer applies cleanly

Hm, actually it depends on fixes you have in your linux-mtd tree and
features in your l2-mtd tree.

I don't know how you usually deal with those problems (merging the
linux-mtd/master branch into the l2-mtd/master one, or merging
last linus' -rc into l2-mtd/master should work), but I'd really
like to have this in 4.4 :-).
I still have the patch using the nand_check_erased_ecc_chunk() function
which depends on those 2 patches, and I'd like to have it in 4.4 too.

I know I'm asking a lot, but as explained earlier, I still have a
bunch of patches on top of those already posted (mainly to support
the hardware randomizer), and I'd like the trivial ones to be merged
quickly.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
