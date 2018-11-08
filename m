From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  8 Nov 2018 19:45:50 +0100
Subject: [PATCH 0/2] efi/arm regression fixes
Message-ID: <20181108184552.14366-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of fixes for ef/arm issues that were introduced before the
merge window.

Ard Biesheuvel (2):
  efi: arm: revert deferred unmap of early memmap mapping
  efi/arm: libstub: pack FDT after populating it

 drivers/firmware/efi/arm-init.c    | 4 ++++
 drivers/firmware/efi/arm-runtime.c | 2 +-
 drivers/firmware/efi/libstub/fdt.c | 4 ++++
 drivers/firmware/efi/memmap.c      | 3 +++
 4 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.19.1
