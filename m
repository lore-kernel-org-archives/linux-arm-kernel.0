From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Jun 2010 15:16:49 +0100
Subject: Context Switching is Broken
In-Reply-To: <20100610140136.GA32362@n2100.arm.linux.org.uk>
References: <503171.97993.qm@web51806.mail.re2.yahoo.com>
	<20100610140136.GA32362@n2100.arm.linux.org.uk>
Message-ID: <004801cb08a7$913a9f90$b3afdeb0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Jun 10, 2010 at 04:11:35AM -0700, Herman Swartz wrote:
> > Context switching is broken. The man page for context is example code
> > that doesn't work, but should. Does a bug report need to be submitted?
> 
> $ man context
> No manual entry for context
> 
> ?
> 

Quite. man makecontext has a fairly scary example, maybe that's
it.

Will
