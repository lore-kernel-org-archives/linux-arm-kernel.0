From: tixy@yxit.co.uk (Tixy)
Date: Thu, 09 Aug 2012 07:59:37 +0100
Subject: [PATCH 01/22] ARM: add mechanism for late code patching
In-Reply-To: <alpine.LFD.2.02.1208081248340.5231@xanadu.home>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
 <1343775898-28345-2-git-send-email-cyril@ti.com>
 <alpine.LFD.2.02.1208040045360.5231@xanadu.home> <50219C45.7030601@ti.com>
 <alpine.LFD.2.02.1208080106500.5231@xanadu.home> <5022673A.7060407@ti.com>
 <alpine.LFD.2.02.1208080948210.5231@xanadu.home>
 <20120808160517.GO18957@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1208081248340.5231@xanadu.home>
Message-ID: <1344495577.2852.4.camel@computer2.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-08-08 at 12:56 -0400, Nicolas Pitre wrote:
> On Wed, 8 Aug 2012, Russell King - ARM Linux wrote:
> > Done correctly, it shouldn't be a problem, but I wouldn't say that
> > arch/arm/kernel/kprobes-test*.c is done correctly.  It's seen quite
> > a number of patching attempts since it was introduced for various
> > problems, and I've seen quite a number of builds fail for various
> > reasons in this file (none which I could be bothered to investigate.)
<snip>
> >
> As for build failures with that test code, I'd suggest you simply drop a 
> note to Tixy who is normally very responsive.

Indeed. If there are build failures, I'm happy to investigate and fix.

-- 
Tixy
