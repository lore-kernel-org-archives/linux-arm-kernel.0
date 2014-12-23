From: bp@alien8.de (Borislav Petkov)
Date: Tue, 23 Dec 2014 17:45:49 +0100
Subject: [PATCH v4 4/8] efi: efistub: allow allocation alignment larger
 than EFI_PAGE_SIZE
In-Reply-To: <1419245944-2424-5-git-send-email-ard.biesheuvel@linaro.org>
References: <1419245944-2424-1-git-send-email-ard.biesheuvel@linaro.org>
 <1419245944-2424-5-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20141223164549.GB3810@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 10:59:00AM +0000, Ard Biesheuvel wrote:
> On systems with 64 KB pages, it is preferable for UEFI memory map
> entries to be 64 KB aligned multiples of 64 KB, because it relieves
> us of having to deal with the residues.
> So, if EFI_ALLOC_ALIGN is #define'd by the platform, use it to round
> up all memory allocations made.
> 
> Acked-by: Matt Fleming <matt.fleming@intel.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
