From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Oct 2011 12:37:01 +0100
Subject: select consuming too much cpu time when changing from kernel
	2.6.29 to 2.6.34
In-Reply-To: <201110201332.50407.Wernerp@cornelius-consult.de>
References: <201110201332.50407.Wernerp@cornelius-consult.de>
Message-ID: <20111020113701.GA21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2011 at 01:32:45PM +0200, Werner Cornelius wrote:
> recently we changed from an older kernel 2.6.29 to a newer one 2.6.34 on an 
> ARM NXP LPC3250 platform.

strace is a wonderful program to monitor the kernel/user API activity -
it would be good if you could strace your test program and confirm
whether it's working as you expect.  (Note that it can measure the time
spent inside a syscall.)
