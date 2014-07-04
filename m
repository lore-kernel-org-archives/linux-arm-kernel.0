From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Jul 2014 18:01:10 +0100
Subject: [PATCH v3] efi/arm64: handle missing virtual mapping for UEFI
 System Table
In-Reply-To: <1404492756.19665.57.camel@deneb.redhat.com>
References: <1404487509-26084-1-git-send-email-ard.biesheuvel@linaro.org>
 <1404492756.19665.57.camel@deneb.redhat.com>
Message-ID: <20140704170110.GM16404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 05:52:36PM +0100, Mark Salter wrote:
> On Fri, 2014-07-04 at 17:25 +0200, Ard Biesheuvel wrote:
> > If we cannot resolve the virtual address of the UEFI System Table, its physical
> > offset must be missing from the virtual memory map, and there is really no point
> > in proceeding with installing the virtual memory map and the runtime services
> > dispatch table. So back out gracefully.
> > 
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> 
> Acked-by: Mark Salter <msalter@redhat.com>

Thanks. Do I take this patch or Matt already has other EFI patches to
push? If the latter:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
