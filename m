From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Fri, 19 Apr 2013 17:16:06 +0100
Subject: [Xen-devel] [PATCH v6 1/4] arm: introduce psci_smp_ops
In-Reply-To: <alpine.LFD.2.03.1304191146230.17375@syhkavp.arg>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <1365167495-18508-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130418161341.GB14496@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1304181714560.7254@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304181237480.17375@syhkavp.arg>
 <alpine.DEB.2.02.1304181749260.7254@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304181336280.17375@syhkavp.arg>
 <alpine.DEB.2.02.1304191035360.7254@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304191146230.17375@syhkavp.arg>
Message-ID: <1366388166.29403.2.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-04-19 at 16:47 +0100, Nicolas Pitre wrote:
> No one should be probing registers without making sure it is safe to do 
> so.  Even on non virtualized hardware this can be a dangerous thing to 
> do.

Won't people writing per machine code consider, not unreasonably, that
having been called through a mdesc machine specific hook constitutes
enough "making sure" that they think it is safe to touch registers which
are specific to that machine?

Ian.
