From: elendil@planet.nl (Frans Pop)
Date: Fri, 25 Sep 2009 22:17:44 +0200
Subject: arm: current mainline fails to boot on QNAP TS-109
In-Reply-To: <alpine.LFD.2.00.0909251547450.4997@xanadu.home>
References: <200909252039.19789.elendil@planet.nl>
	<alpine.LFD.2.00.0909251547450.4997@xanadu.home>
Message-ID: <200909252217.46021.elendil@planet.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 September 2009, you wrote:
> On Fri, 25 Sep 2009, Frans Pop wrote:
> > Current mainline kernel fails to boot on my QNAP TS-109 (orion5x).
> >
> > It fails immediately after uncompressing the kernel, there are no
> > other messages on the serial console. The problem was probably
> > introduced in the last ARM merge:
> >
> > v2.6.31-8766-gf25f60b is OK
> > v2.6.31-8936-g851b147 fails
> >
> > If needed I can run a bisect between those commits.
>
> No need -- I found the screw-up.  Will submit a patch right away.

Great. I thought someone might, given that it was a fairly small range.

> In the mean time just revert commit 200b812d00.

Thanks!
