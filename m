From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Sep 2011 00:06:53 -0400 (EDT)
Subject: [PATCH 01/19] ARM: sort the meminfo array earlier
In-Reply-To: <alpine.LFD.2.00.1109171148390.20358@xanadu.home>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<1316156850-31013-2-git-send-email-nico@fluxnic.net>
	<20110917150522.GI16381@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109171148390.20358@xanadu.home>
Message-ID: <alpine.LFD.2.00.1109182340370.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 17 Sep 2011, Nicolas Pitre wrote:

> On Sat, 17 Sep 2011, Russell King - ARM Linux wrote:
> 
> > On Fri, Sep 16, 2011 at 03:07:12AM -0400, Nicolas Pitre wrote:
> > > From: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > 
> > > The meminfo array has to be sorted before sanity_check_meminfo() can work
> > > properly.
> > 
> > This is unrelated to the patch series, so it should be separate from the
> > series.  I don't see anything in the series depending on it.
> 
> True.  I just stumbled across this issue while working on the rest.

Well, I'm about to post some revised patches for this series, and I'm 
now taking advantage of the sorted array.  So here's this patch again 
which is also revised:

----- >8
