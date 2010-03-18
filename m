From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 18 Mar 2010 07:14:05 -0600
Subject: devicetree in arm
In-Reply-To: <dac45061003180504k49a9f303y4329530a5b475108@mail.gmail.com>
References: <dac45061003180504k49a9f303y4329530a5b475108@mail.gmail.com>
Message-ID: <fa686aa41003180614g574b9d91o5926f94a59ad5ec9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 18, 2010 at 6:04 AM, Mark Ryden <markryde@gmail.com> wrote:
> Hello,
> According to :
> http://lwn.net/Articles/375296/
> Some patches that add basic ARM device tree support
> were sent,
>
> In the link above, there is a link to a git tree here:
> git://git.secretlab.ca/git/linux-2.6 test-devicetree
>
> I git-cloned this tree, and I don't have arch/arm/kernel/devtree.c
>
> Am I missing something ?

ARM device tree support is very much in flux, and that particular
branch gets rebased a lot as device tree code from Sparc, Microblaze
and Powerpc is merged into drivers/of.  I may have ended up pushing
out to test-devicetree without the ARM patches applied.  I'll look at
it today, make sure the ARM stuff is all there, and then push it out
again.

Note however that this is only very basic support.  It doesn't yet
have the code needed to register devices and drivers from device tree
data.  That will be coming real-soon-now.

g.
