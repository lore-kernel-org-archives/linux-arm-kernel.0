From: greg@kroah.com (Greg KH)
Date: Wed, 1 Aug 2012 05:37:38 -0700
Subject: [2/3][PATCH][v2] TDM Framework
In-Reply-To: <3F1D9DCAAB49B94D88DBE05911FA4E6E515F98@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20120727152542.GB1613@electric-eye.fr.zoreil.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E511121@039-SN1MPN1-006.039d.mgd.msft.net>
 <20120730160146.GB28703@kroah.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E515F98@039-SN1MPN1-001.039d.mgd.msft.net>
Message-ID: <20120801123738.GA28291@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 12:13:19PM +0000, Singh Sandeep-B37400 wrote:
> > On Mon, Jul 30, 2012 at 09:50:57AM +0000, Singh Sandeep-B37400 wrote:
> > > 1. You should send some kernel mode TDM clients. Without those the
> > framework
> > >    is pretty useless.
> > > [Sandeep] We do have a test client but not good enough to be pushed in
> > > open source, should we add it to documentation??
> > 
> > Then how do you know if the framework is "correct" and good enough for
> > real clients?  We don't add frameworks, or apis, to the kernel without
> > users, so you will have to come up with some users before we can accept
> > it.
> We can only say that this framework is available in FSL BSPs and being used by VoIP companies.
> But running a complete voice stack itself is beyond the scope of Freescale.
> So vendors integrate their solutions with FSL solution.
> To test the framework we have a small application in our BSP (this is a very basic test client) which tests the TDM driver and the SLIC interface from voice  transfer perspective.
> We can get this added in the Linux codebase in some test directory. What could be a good place for this?

tools/ is a good place for that.

And sorry, I was thinking you had kernel drivers that attached to this
framework, not userspace programs.  Actually, what is the user/kernel
interface for this framework, I seem to have missed that entirely.  You
will have to document that quite well, and run it by the linux-api
mailing list.

thanks,

greg k-h
