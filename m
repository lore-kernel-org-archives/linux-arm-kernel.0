From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Oct 2009 14:28:58 +0000
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <200910271514.54506.jpihet@mvista.com>
References: <1256123277.3851.36.camel@debian-nb>
	<20091025154416.GB1774@n2100.arm.linux.org.uk>
	<af3ea28a0910251959id60ad5kf95dd1f908fa55c9@mail.gmail.com>
	<200910271514.54506.jpihet@mvista.com>
Message-ID: <20091027142858.GA22412@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2009 at 03:14:53PM +0100, Jean Pihet wrote:
> Russell, Janboe,
> 
> On Monday 26 October 2009 03:59:23 ye janboe wrote:
> > Sure. Russell
> >
> > After you restart_syscall patch are merged, I will send out another patch.
> Here is what I ended up with after merging.
> It has been tested on OMAP3 boards although I could not trigger the failing 
> put_user test case.
> 
> What do you think?

Looks fine, thanks.
