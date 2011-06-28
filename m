From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Jun 2011 13:13:34 +0100
Subject: Problem with GDB when debugging IRQ handlers
In-Reply-To: <BANLkTinvrJ5MAZABDmdmQk6UZHDKJQo1+A@mail.gmail.com>
References: <20110627125306.GA30646@doriath.ww600.siemens.net>
	<20110627132735.GE16103@n2100.arm.linux.org.uk>
	<4E088DE1.2060809@gmail.com> <4E089AB3.1090801@codesourcery.com>
	<20110628103946.GC21898@n2100.arm.linux.org.uk>
	<BANLkTinvrJ5MAZABDmdmQk6UZHDKJQo1+A@mail.gmail.com>
Message-ID: <20110628121334.GE21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 04:06:11PM +0400, Dmitry Eremin-Solenikov wrote:
> For the reference I'm providing the patch in the attachment.
> 
> Russell, will you agree to merge at least this partial solution, so
> that gdb chokes,
> but doesn't go to indefinite recursion? If you'd agree, I'll submit it
> with proper
> headers and sign-off.

It looks like it does the right thing, but I think we need someone who
knows how the debug info is supposed to work comment.

Adding Catalin to the thread to see whether Catalin has any comments;
Catalin added the original unwinder annotations.
