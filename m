From: horms@verge.net.au (Simon Horman)
Date: Tue, 19 Feb 2013 10:18:32 +0900
Subject: [PATCH v3 8/8] ARM: shmobile: completely switch MMC interfaces
 on armadillo800eva-reference to DT
In-Reply-To: <CABYn4sw33o6nDQz2wvuxgiKEMUuSdxNZa3J_SmO4XFMH3+5eqQ@mail.gmail.com>
References: <1358959071-2873-1-git-send-email-g.liakhovetski@gmx.de>
 <1358959071-2873-9-git-send-email-g.liakhovetski@gmx.de>
 <CABYn4sz+EMFB5cb4Uyk17+KfmakRCPOXx7NQkPcQOfvT5DDWYg@mail.gmail.com>
 <CABYn4sxWpS6K21YNPKEdQ9e3xwbivOKSOs9w2+mLRiuizWmHXw@mail.gmail.com>
 <Pine.LNX.4.64.1302182050550.4526@axis700.grange>
 <CABYn4sw33o6nDQz2wvuxgiKEMUuSdxNZa3J_SmO4XFMH3+5eqQ@mail.gmail.com>
Message-ID: <20130219011831.GI14932@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 01:59:56PM -0600, Bastian Hecht wrote:
> 2013/2/18 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> > Hi Bastian
> >
> > On Mon, 18 Feb 2013, Bastian Hecht wrote:
> >
> >> Hi,
> >>
> >> I got out of place by 1 commit in the intc-of branch:
> >> It's "ARM: shmobile: move pin configuration on
> >> armadillo800eva-reference to DT" not "ARM: shmobile: completely switch
> >> MMC interfaces on armadillo800eva-reference to DT" that breaks "make
> >> dtbs".

Thanks for pointing that out.

I have resolved this problem by rebasing the topic/intc-of branch
on a merge that includes the topic/pinmux branch. topic/pinmux includes
the following patch which provides 'gpio'.

* ARM: shmobile: r8a7740: Add pin control device in device tree

> > Could you please try the topic/all+next branch? It should contain all
> > other branches and as such be the most complete one.

Yes, it is the most complete one.

> Oh great, thanks for pointing out the correct branch to me! This one
> looks good for my testing purposes.
