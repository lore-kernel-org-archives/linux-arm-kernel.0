From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Apr 2013 01:25:19 -0700
Subject: [PATCH 0/4 v6] arm: introduce psci_smp_ops and use them on Xen
In-Reply-To: <alpine.DEB.2.02.1304081102500.5353@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1304081102500.5353@kaball.uk.xensource.com>
Message-ID: <20130411082519.GD31465@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 12:05:17PM +0100, Stefano Stabellini wrote:
> Arnd, Olof,
> do you have any thoughts on this series?
> Would you be happy to carry it in the arm-soc tree?
> 
> The last patch, "xen/arm: introduce xen_early_init, use PSCI on xen" has
> a (small) dependency on this series:
> 
> http://marc.info/?l=linux-kernel&m=136430893610688&w=2
> 
> would you be OK with taking that one too, or should that go through the
> Xen tree?

I think it'd make sense to get Russell to ack the changes to the core ARM code.
We can merge the series through arm-soc, or he can take them, whatever is
easiest for everybody.

Given the dependencies on the second branch it might be easier to merge
through Russell's tree.


-Olof
