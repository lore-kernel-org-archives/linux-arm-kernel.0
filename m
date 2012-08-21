From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Aug 2012 15:13:37 +0100
Subject: [2/3][PATCH][v2] TDM Framework
In-Reply-To: <20120801123738.GA28291@kroah.com>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20120727152542.GB1613@electric-eye.fr.zoreil.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E511121@039-SN1MPN1-006.039d.mgd.msft.net>
 <20120730160146.GB28703@kroah.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E515F98@039-SN1MPN1-001.039d.mgd.msft.net>
 <20120801123738.GA28291@kroah.com>
Message-ID: <20120821141336.GD21557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 05:37:38AM -0700, Greg KH wrote:
> On Wed, Aug 01, 2012 at 12:13:19PM +0000, Singh Sandeep-B37400 wrote:

> > But running a complete voice stack itself is beyond the scope of Freescale.
> > So vendors integrate their solutions with FSL solution.

> And sorry, I was thinking you had kernel drivers that attached to this
> framework, not userspace programs.  Actually, what is the user/kernel
> interface for this framework, I seem to have missed that entirely.  You
> will have to document that quite well, and run it by the linux-api
> mailing list.

This does also sound like we ought to be playing nicer with ALSA rather
than just providing a binary only pipe...
