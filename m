From: B19295@freescale.com (Lin Tony-B19295)
Date: Wed, 20 Jul 2011 11:08:06 +0000
Subject: [PATCH 5/7] ehci mxc: make it more flexible to be used for mx28
In-Reply-To: <874o2hp5z0.fsf@lebrac.rtp-net.org>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
	<1311160106-4898-6-git-send-email-tony.lin@freescale.com>
	<874o2hp5z0.fsf@lebrac.rtp-net.org>
Message-ID: <97D3A72708D04647A5AC84A04996E5B5161673@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnaud Patard [mailto:arnaud.patard at rtp-net.org]
> Sent: Wednesday, July 20, 2011 7:06 PM
> To: Lin Tony-B19295
> Cc: linux-usb at vger.kernel.org; koen.beel.barco at gmail.com; balbi at ti.com;
> linux-arm-kernel at lists.infradead.org; Sascha Hauer
> Subject: Re: [PATCH 5/7] ehci mxc: make it more flexible to be used for
> mx28
> 
> Tony Lin <tony.lin@freescale.com> writes:
> Hi,
> 
> > old driver uses some hard coding for clks' name which could not be
> > used for mx28. So workaround these hard codings by judging the cpu is
> > mx28 or not.
> 
> Sascha had some patches to solve this in a different way, avoiding to add
> yet an other cpu_is_* check for ahb clock. Don't know their current
> status.

Yes, using cpu_is_* is really a bad method here :-)
But I had to follow that bad method so far, hope we could see some change from sascha. 


> 
> See:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-
> February/040364.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-
> February/040365.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-
> February/040363.html
> 
> Arnaud
