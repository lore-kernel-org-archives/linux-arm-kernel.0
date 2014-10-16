From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 16 Oct 2014 10:01:06 +0900
Subject: [GIT PULL 2/2] Samsung defconfig updates for v3.18
In-Reply-To: <1413380267.4565.1.camel@collabora.co.uk>
References: <543DB158.7030303@samsung.com>
 <CAOesGMgRBq93diDmA-21UYkFQTZu+LiF9gV+A==GS5uGW9n-Vg@mail.gmail.com>
 <1413380267.4565.1.camel@collabora.co.uk>
Message-ID: <00e601cfe8dc$abf25bb0$03d71310$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sjoerd Simons wrote:
> > On Tue, 2014-10-14 at 23:32 -0700, Olof Johansson wrote:
> > On Tue, Oct 14, 2014 at 4:27 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > > tags/samsung-defconfig
> > >
> > > for you to fetch changes up to 508423bebcda29eb0ba7c627f895387dad7cdcd6:
> > >
> > >   ARM: exynos_defconfig: enable USB gadget support (2014-09-25 18:20:18
> > > +0900)
> >
> > Merged, thanks.
> 
> Hrm, enabling USB gadget support will actually regress USB on Exynos
> peach boards and Arndale Octa without some of the DT fixes that landed
> in armsoc next/late branch. Specifically:
> 
> 5c42acdbffff9bab595482b966b22ab5e2f6f359
> dbb62ef9ade6e92737d3fac199665b8b7c455959
> 
Yeah...I've missed it. Sorry.

> Might be good to cherry-pick those into for-next at this point (they're
> rather trivial)
> 
So...Olof, can you please cherry pick them into arm-soc/fixes? Or shall I send
pull-request for them again?

- Kukjin
