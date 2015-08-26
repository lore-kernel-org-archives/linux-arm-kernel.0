From: horms@verge.net.au (Simon Horman)
Date: Wed, 26 Aug 2015 09:27:25 +0900
Subject: [PATCH] ARM: shmobile: remove Makefile.boot
In-Reply-To: <CAMuHMdWYM6vVWzUQgR4u8cvoH6Jtq4XerYd2PbpvfUruDPi7-Q@mail.gmail.com>
References: <1440113264-30359-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWYM6vVWzUQgR4u8cvoH6Jtq4XerYd2PbpvfUruDPi7-Q@mail.gmail.com>
Message-ID: <20150826002724.GA11168@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 02:06:31PM +0200, Geert Uytterhoeven wrote:
> On Fri, Aug 21, 2015 at 1:27 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Now that the only multiplatform boot is supported for all
> > shmobile platforms Makefile.boot may be removed.
> >
> > This seems correct to me given:
> > * Setting MACHINE to no value in arch/arm/Makefile
> >   if CONFIG_ARCH_MULTIPLATFORM is set
> > * Not including Makefile.boot in arch/arm/boot/Makefile
> >   if MACHINE has no value
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up for v4.4.
