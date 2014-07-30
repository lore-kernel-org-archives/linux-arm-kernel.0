From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jul 2014 15:22:10 +0100
Subject: [RFC PATCH 04/10] arm64: add EFI little endian constants to
 linker script
In-Reply-To: <20140730141805.GA15082@console-pimps.org>
References: <1405955785-13477-1-git-send-email-ard.biesheuvel@linaro.org>
 <1405955785-13477-5-git-send-email-ard.biesheuvel@linaro.org>
 <20140730141805.GA15082@console-pimps.org>
Message-ID: <20140730142209.GC8989@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 03:18:05PM +0100, Matt Fleming wrote:
> On Mon, 21 Jul, at 05:16:19PM, Ard Biesheuvel wrote:
> > Similar to how text offset and kernel size are mangled to produce little
> > endian constants for the Image header regardless of the endianness of the
> > kernel, this adds a number of constants used in the EFI PE/COFF header which
> > can only be calculated (and byte swapped) by the linker.
> > 
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/kernel/image.h | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> Where is this file? I can't find it in Linus' tree.

It's queued in the arm64 tree for 3.17 (should also appear in -next at the
moment).

See commit a2c1d73b94ed ("arm64: Update the Image header").

Will
