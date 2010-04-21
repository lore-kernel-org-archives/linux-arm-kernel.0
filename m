From: rabin@rab.in (Rabin Vincent)
Date: Thu, 22 Apr 2010 00:53:19 +0530
Subject: [PATCH 05/10] ARM: ftrace: add ENDPROC annotations
In-Reply-To: <20100313084546.GA30400@n2100.arm.linux.org.uk>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
	<1268462987-8271-6-git-send-email-rabin@rab.in>
	<20100313084546.GA30400@n2100.arm.linux.org.uk>
Message-ID: <20100421192319.GA16719@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 13, 2010 at 08:45:46AM +0000, Russell King - ARM Linux wrote:
> On Sat, Mar 13, 2010 at 12:19:42PM +0530, Rabin Vincent wrote:
> >  
> >  	.globl ftrace_stub
> > -ftrace_stub:
> > +ENTRY(ftrace_stub)
> 
> ENTRY does the .globl for you, so please kill your own version.

Updated patch below.
