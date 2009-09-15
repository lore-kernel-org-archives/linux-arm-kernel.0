From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Tue, 15 Sep 2009 12:37:59 +0300
Subject: [RFC] ptrace: system call number interpretation during
	PTRACE_SET_SYSCALL request handling
In-Reply-To: <20080601083036.GD5818@flint.arm.linux.org.uk>
References: <484047C3.4090509@gmail.com>
	<20080601083036.GD5818@flint.arm.linux.org.uk>
Message-ID: <cc557aab0909150237u451eaab0v82f08eb65ef706a2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 1, 2008 at 11:30 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, May 30, 2008 at 09:30:27PM +0300, Volodymyr G. Lukiianyk wrote:
>> I've encountered a problem while running strace on the kernel with
>> CONFIG_AEABI not set. This problem can be worked around in userspace,
>> but it looks like the correct place for a fix is the kernel.
>
> I'm really nervous about this. ?I need to check what my own strace
> patches do - and if they don't suffer from this problem I'd say that
> the bug lies in userspace.

Any results? Do we need to workaround it in user space or it will be
fixed in kernel?

> Yes, for a long time I've had patches to strace to add proper ARM
> support and fix a load of issues with it, but I've never been able
> to get them integrated into strace itself.
>
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ: ? ? ? ?http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette: ?http://www.arm.linux.org.uk/mailinglists/etiquette.php
>
