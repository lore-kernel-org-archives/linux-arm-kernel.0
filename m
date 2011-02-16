From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Feb 2011 17:11:24 -0500 (EST)
Subject: [PATCH 2/2] ARM: remove the 4x expansion presumption while
	decompressing the kernel
In-Reply-To: <4D5C47C7.6010006@codeaurora.org>
References: <1297892343-29064-1-git-send-email-nico@fluxnic.net>
	<1297892343-29064-2-git-send-email-nico@fluxnic.net>
	<4D5C47C7.6010006@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1102161707180.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Feb 2011, Stephen Boyd wrote:

> On 02/16/2011 01:39 PM, Nicolas Pitre wrote:
> > -LDFLAGS_vmlinux := --defsym zreladdr=$(ZRELADDR)
> > +LDFLAGS_vmlinux += --defsym zreladdr=$(ZRELADDR)
> 
> What is this for?

It replaces the assignment operator with an addition operator ?


Nicolas
