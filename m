From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Apr 2013 15:23:18 +0100
Subject: [PATCH v6 1/4] arm: introduce psci_smp_ops
In-Reply-To: <alpine.DEB.2.02.1304181748010.7254@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <1365167495-18508-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130418161341.GB14496@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1304181714560.7254@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304181233580.17375@syhkavp.arg>
 <alpine.DEB.2.02.1304181748010.7254@kaball.uk.xensource.com>
Message-ID: <20130422142318.GL14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 05:49:21PM +0100, Stefano Stabellini wrote:
> On Thu, 18 Apr 2013, Nicolas Pitre wrote:
> > Please let's keep the order as we discussed.  Otherwise this is just too 
> > confusing (Russell's comment is a good example of that).
> 
> You are right, it is confusing.
> By "keep the order as we discussed", do you mean merge the second patch
> into the first one, correct?

Well, the solution to this kind of confusion is to ignore comments on the
older patches and post a new set of patches and ask for all relevant
comments to be against that set and that set only.
