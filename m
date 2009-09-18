From: dan@debian.org (Daniel Jacobowitz)
Date: Fri, 18 Sep 2009 10:10:04 -0400
Subject: Problems with pthread on ARM/PXA270
In-Reply-To: <200909181206.59595.schindele@nentec.de>
References: <200909160926.02036.schindele@nentec.de>
	<20090916144051.GA19307@caradoc.them.org>
	<200909181206.59595.schindele@nentec.de>
Message-ID: <20090918141004.GA6988@caradoc.them.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2009 at 12:06:59PM +0200, Juergen Schindele wrote:
> sched_clock is apparently not implemented the same way in all kernel versions.
> What about thread implementation in codesourcery compiler ? Are they 
> "linux-threads" or "Native Posix thread library" or is it possible that there 
> are important bugfixes til the version i use ???

NPTL in any recent version.  I don't remember for the ancient version
you said you were using; consider an update.

-- 
Daniel Jacobowitz
CodeSourcery
