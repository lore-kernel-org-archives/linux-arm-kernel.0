From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Nov 2015 17:35:47 +0000
Subject: [PATCH 0/2] arm64 efi fixes
In-Reply-To: <1448264604-19411-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1448264604-19411-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151123173547.GD1702@arm.com>
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

These both look like straightforward fixes to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

I assume Catalin will pick them up. Do they need to go to -stable?

Will
