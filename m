From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 14 Sep 2011 15:23:26 +0100
Subject: [PATCH 4/6] ARM: zImage: gather some string functions into
	string.c
In-Reply-To: <alpine.LFD.2.00.1109140942250.20358@xanadu.home>
References: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
	<1315978906-15829-5-git-send-email-nico@fluxnic.net>
	<20110914131314.GC2104@arm.com>
	<alpine.LFD.2.00.1109140942250.20358@xanadu.home>
Message-ID: <20110914142326.GG2104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 09:45:00AM -0400, Nicolas Pitre wrote:
> On Wed, 14 Sep 2011, Dave Martin wrote:
> 
> > Have you seen this?
> > http://en.wikipedia.org/wiki/Duff%27s_device
> 
> Yeah... I did stumble across something similar in the gcc test suite.
> 
> > Once I finished vomiting, this actually struck be as rather neat.
> > 
> > If I've understood right, it seems a good fit for the manual unrolling
> > you do here.
> 
> Maybe.  However this patch is about moving code, not "improving" it.  ;-)

Fair enough -- it was really just a side-comment rather than an issue
with the patch.

---Dave
