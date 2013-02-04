From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Feb 2013 12:23:55 +0000
Subject: [RFC PATCH] arm: decompressor: initialize PIC offset base
 register for uClinux tools
In-Reply-To: <510FA7A4.5030409@arm.com>
References: <1359480546-7033-1-git-send-email-jonathan.austin@arm.com>
 <alpine.LFD.2.02.1301291453530.6300@xanadu.home> <510BF0B3.3030608@arm.com>
 <20130201181854.GU23505@n2100.arm.linux.org.uk> <510FA2C0.3020505@arm.com>
 <20130204120708.GB17786@n2100.arm.linux.org.uk> <510FA7A4.5030409@arm.com>
Message-ID: <20130204122355.GC17786@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 12:20:52PM +0000, Jonathan Austin wrote:
> My experience is that my toolchain behaves much like most other uclinux  
> toolchains - I've just checked:
> - Codesourcery
> - A Pengutronix one for the M3
> - An ARM one
>
> And they all default to using r9.
>
> So shall I put the -m*no*-single-pic-base one in to the patch system?

Yup, though I don't think I'll be pushing it until the next merge window.
