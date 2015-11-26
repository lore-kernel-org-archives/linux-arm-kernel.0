From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 26 Nov 2015 18:16:18 +0000
Subject: [PATCH 0/2] arm64 efi fixes
In-Reply-To: <1448264604-19411-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1448264604-19411-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151126181618.GT3109@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 08:43:22AM +0100, Ard Biesheuvel wrote:
> Two minor issues that were spotted by Matt Fleming and Russell King during
> review of the UEFI for 32-bit ARM series. No point in delaying these fixes
> until the whole series gets acked, so I am sending them out separately
> beforehand.
> 
> Ard Biesheuvel (2):
>   arm64/efi: deal with NULL return value of early_memremap()
>   arm64: efi: fix initcall return values

Patches applied. Thanks.

-- 
Catalin
