From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Jul 2014 14:38:44 +0100
Subject: [PATCH 1/2] efi/arm64: fix potential NULL dereference of
 efi.systab
In-Reply-To: <1404295802-28030-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1404295802-28030-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140704133844.GG16404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 11:10:01AM +0100, Ard Biesheuvel wrote:
> We assign efi.systab using efi_lookup_mapped_addr(), and test for !NULL, but
> then go on an dereference it anyway.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks. I applied this one (the other patch needs to go in via a
different route).

-- 
Catalin
