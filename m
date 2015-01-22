From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 Jan 2015 15:59:24 +0000
Subject: [PATCH] arm64/efi: move virtmap init to early initcall
In-Reply-To: <1421920900-27028-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1421920900-27028-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150122155924.GC28096@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 10:01:40AM +0000, Ard Biesheuvel wrote:
> Now that the create_mapping() code in mm/mmu.c is able to support
> setting up kernel page tables at initcall time, we can move the whole
> virtmap creation to arm64_enable_runtime_services() instead of having
> a distinct stage during early boot. This also allows us to drop the
> arm64-specific EFI_VIRTMAP flag.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied. Thanks.

-- 
Catalin
