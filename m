From: horms@verge.net.au (Simon Horman)
Date: Fri, 14 Feb 2014 11:19:30 +0900
Subject: [PATCH/RFC] ARM: shmobile: Add defconfig for shmobile mulitplatfom
In-Reply-To: <CANqRtoTT4iY4Bx_EFrXD810ygrXW8WyVN-f5ggnpDY0n1FqPWg@mail.gmail.com>
References: <1392337944-4000-1-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoTT4iY4Bx_EFrXD810ygrXW8WyVN-f5ggnpDY0n1FqPWg@mail.gmail.com>
Message-ID: <20140214021924.GA29260@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 10:57:50AM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Fri, Feb 14, 2014 at 9:32 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > This is intended to be a base for a defconfig to cover all
> > shmobile multiplatform boards. It currently includes configuration
> > for the following boards:
> >
> > * KZM9D
> > * Lager
> > * Koelsch
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Thanks for this! This shared defconfig looks like a good first step.
> 
> Regarding KZM9D, I believe the board is using a SMSC chip for
> ethernet. Also EMEV2 is using EM_STI for timer. If you go decided to
> make a V2 then can you please make sure those are included? We can
> also deal with it incrementally.

Sure, I will make v2.

I suspect there are other things I missed.
But I'm happy to fix up the ones we know about now.
