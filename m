From: herman_swartz@yahoo.com (Herman Swartz)
Date: Thu, 10 Jun 2010 16:26:47 -0700 (PDT)
Subject: Context Switching is Broken
In-Reply-To: <20100610225930.GD32362@n2100.arm.linux.org.uk>
References: <503171.97993.qm@web51806.mail.re2.yahoo.com>
	<20100610140136.GA32362@n2100.arm.linux.org.uk>
	<20100610142015.GC32362@n2100.arm.linux.org.uk>
	<AANLkTimeZ6xawjcYfVDohBFcMbbLlC3h2gDs91CyGcBX@mail.gmail.com>
	<148780.29764.qm@web51806.mail.re2.yahoo.com>
	<AANLkTilfwCVpr7JrLlWLIXV1DtAGZyRpvDd_8W-qfq5t@mail.gmail.com>
	<20100610225930.GD32362@n2100.arm.linux.org.uk>
Message-ID: <938111.34490.qm@web51801.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yes, the kernel has the functions, because the kernel uses them in it's operation. The glibc needs to implement these calls to the kernel. Do I have that right?

Herman



----- Original Message ----
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Martin Guy <martinwguy@gmail.com>
Cc: Herman Swartz <herman_swartz@yahoo.com>; Will Deacon <will.deacon@arm.com>; linux-arm-kernel at lists.infradead.org
Sent: Thu, June 10, 2010 6:59:30 PM
Subject: Re: Context Switching is Broken

On Thu, Jun 10, 2010 at 10:29:12PM +0100, Martin Guy wrote:
> While context switching works fine - any Unix system would have a hard
> time working without it - these four esoteric system calls are not
> implemented in the ARM port of Linux. If you'd like to modify the
> linux source code to implement them, I'm sure the community would be
> happy to review the patches for inclusion in the next version of the
> kernel.

If you read what I said:

"I believe for glibc, these are simply unimplemented on ARM, and linking
a program which uses makecontext with glibc would result in the linker
issuing:"

These calls are nothing to do with the kernel.? They're a subject purely
for glibc.? So there's no modification to the Linux kernel source code
which could effect their implementation.



      
