From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Jul 2010 12:37:06 +0100
Subject: [PATCH] ARM: clean files in arch/arm/boot/compressed/
In-Reply-To: <20100727092921.3620.51711.sendpatchset@t400s>
References: <20100727092921.3620.51711.sendpatchset@t400s>
Message-ID: <20100727113706.GB11468@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 27, 2010 at 06:29:21PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the compressed boot Makefile for ARM to
> remove files during clean.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Perhaps there is a better way to do this?

That'll do - can you stick it in the patch system please, and I'll try
to get it in before 2.6.35 is released.
