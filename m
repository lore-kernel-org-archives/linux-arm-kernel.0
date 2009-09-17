From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Sep 2009 21:52:21 +0100
Subject: [RFC] ptrace: system call number interpretation during
	PTRACE_SET_SYSCALL request handling
In-Reply-To: <cc557aab0909171341w28b2f5b7ye4145132621051ea@mail.gmail.com>
References: <484047C3.4090509@gmail.com>
	<20080601083036.GD5818@flint.arm.linux.org.uk>
	<cc557aab0909150237u451eaab0v82f08eb65ef706a2@mail.gmail.com>
	<cc557aab0909171341w28b2f5b7ye4145132621051ea@mail.gmail.com>
Message-ID: <20090917205221.GC12766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2009 at 11:41:43PM +0300, Kirill A. Shutemov wrote:
> On Tue, Sep 15, 2009 at 12:37 PM, Kirill A. Shutemov
> <kirill@shutemov.name> wrote:
> > On Sun, Jun 1, 2008 at 11:30 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >> On Fri, May 30, 2008 at 09:30:27PM +0300, Volodymyr G. Lukiianyk wrote:
> >>> I've encountered a problem while running strace on the kernel with
> >>> CONFIG_AEABI not set. This problem can be worked around in userspace,
> >>> but it looks like the correct place for a fix is the kernel.
> >>
> >> I'm really nervous about this. ?I need to check what my own strace
> >> patches do - and if they don't suffer from this problem I'd say that
> >> the bug lies in userspace.
> >
> > Any results? Do we need to workaround it in user space or it will be
> > fixed in kernel?
> 
> Russell?

I've not really been around much the last three days.

What was the issue again?
