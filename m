From: matt@console-pimps.org (Matt Fleming)
Date: Wed, 20 Aug 2014 18:10:57 +0100
Subject: [PATCH v2 3/3] arm64/efi: efistub: don't abort if base of DRAM
 is occupied
In-Reply-To: <20140814113204.GE24018@leverpostej>
References: <1406717944-24725-1-git-send-email-ard.biesheuvel@linaro.org>
 <1406717944-24725-4-git-send-email-ard.biesheuvel@linaro.org>
 <20140814113204.GE24018@leverpostej>
Message-ID: <20140820171057.GG29733@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Aug, at 12:32:05PM, Mark Rutland wrote:
> On Wed, Jul 30, 2014 at 11:59:04AM +0100, Ard Biesheuvel wrote:
> > If we cannot relocate the kernel Image to its preferred offset of base of DRAM
> > plus TEXT_OFFSET, instead relocate it to the lowest available 2 MB boundary plus
> > TEXT_OFFSET. We may lose a bit of memory at the low end, but we can still
> > proceed normally otherwise.
> > 
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Acked-by: Mark Salter <msalter@redhat.com>
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Ard, who's picking this up?

-- 
Matt Fleming, Intel Open Source Technology Center
