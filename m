From: will.deacon@arm.com (Will Deacon)
Date: Mon,  1 Oct 2018 15:24:46 +0100
Subject: [PATCH 0/2] Fixup and extend hwcaps documentation
Message-ID: <1538403888-13277-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

These two patches fix some silly typos in our hwcaps documentation and
extend it to cover the SSBS support, which is queued in -next.

Cheers,

Will

--->8

Giacomo Travaglini (1):
  arm64: docs: Fix typos in ELF hwcaps

Will Deacon (1):
  arm64: docs: Document SSBS HWCAP

 Documentation/arm64/elf_hwcaps.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.1.4
