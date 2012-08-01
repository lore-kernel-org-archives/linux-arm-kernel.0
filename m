From: B37400@freescale.com (Singh Sandeep-B37400)
Date: Wed, 1 Aug 2012 12:13:19 +0000
Subject: [2/3][PATCH][v2] TDM Framework
In-Reply-To: <20120730160146.GB28703@kroah.com>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20120727152542.GB1613@electric-eye.fr.zoreil.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E511121@039-SN1MPN1-006.039d.mgd.msft.net>
 <20120730160146.GB28703@kroah.com>
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E515F98@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




> -----Original Message-----
> From: Greg KH [mailto:greg at kroah.com]
> Sent: Monday, July 30, 2012 9:32 PM
> To: Singh Sandeep-B37400
> Cc: Francois Romieu; devel at driverdev.osuosl.org; linuxppc-
> dev at lists.ozlabs.org; galak at kernel.crashing.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [2/3][PATCH][v2] TDM Framework
> 
> On Mon, Jul 30, 2012 at 09:50:57AM +0000, Singh Sandeep-B37400 wrote:
> > 1. You should send some kernel mode TDM clients. Without those the
> framework
> >    is pretty useless.
> > [Sandeep] We do have a test client but not good enough to be pushed in
> > open source, should we add it to documentation??
> 
> Then how do you know if the framework is "correct" and good enough for
> real clients?  We don't add frameworks, or apis, to the kernel without
> users, so you will have to come up with some users before we can accept
> it.
We can only say that this framework is available in FSL BSPs and being used by VoIP companies.
But running a complete voice stack itself is beyond the scope of Freescale.
So vendors integrate their solutions with FSL solution.
To test the framework we have a small application in our BSP (this is a very basic test client) which tests the TDM driver and the SLIC interface from voice  transfer perspective.
We can get this added in the Linux codebase in some test directory. What could be a good place for this?

Regards
Sandeep
