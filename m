From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 23 Nov 2015 08:43:22 +0100
Subject: [PATCH 0/2] arm64 efi fixes
Message-ID: <1448264604-19411-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two minor issues that were spotted by Matt Fleming and Russell King during
review of the UEFI for 32-bit ARM series. No point in delaying these fixes
until the whole series gets acked, so I am sending them out separately
beforehand.

Ard Biesheuvel (2):
  arm64/efi: deal with NULL return value of early_memremap()
  arm64: efi: fix initcall return values

 arch/arm64/kernel/efi.c | 24 +++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

-- 
1.9.1
