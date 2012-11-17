From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sun, 18 Nov 2012 00:27:11 +0100 (CET)
Subject: [PATCH 0/5] i2c-sh_mobile non-urgent changes
In-Reply-To: <50A5FF0D.4020502@renesas.com>
References: <5087C93F.6080601@renesas.com>
 <20121116080704.GC8464@pengutronix.de>
 <50A5FF0D.4020502@renesas.com>
Message-ID: <Pine.LNX.4.64.1211180022331.30062@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Nov 2012, Shinya Kuribayashi wrote:

> On 11/16/2012 5:07 PM, Wolfram Sang wrote:
> > Looks good to me, like the extensive patch descriptions. I am going to
> > apply it to for-next with patches 2+3 squashed, because after patch 2 we
> > would have a buggy state otherwise. Let me know if you are not okay with
> > that.
> 
> It's not that buggy as you/we think, in most cases it work without
> problem.  What's more important for me is to record the issue and
> how to solve it.  So I'd like to have patch 2 and 3 separately.

I agree with Wolfram. For developers it can be important to know their own 
development process, that's true. But for upstream it is an absolute 
preference to avoid breakages. So, we should never commit patches, that 
are known to contain problems. In this case it means, that patches 2 and 3 
should be merged. It is good, that the problem has been detected and fixed 
during development or testing, this gives us a chance to avoid breaking 
the mainline, which we should certainly use.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
