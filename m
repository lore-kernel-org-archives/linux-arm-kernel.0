From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Mar 2015 15:20:50 +0100
Subject: [PATCH v4 0/2] ARM: CPU feature detection
Message-ID: <1426688452-10804-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the code for detection of Crypto Extensions capability, now split
into two patches to implement the correct handling of the signed feature
blocks for existing code as well (as per Russell's request)

Ard Biesheuvel (2):
  ARM: treat CPU feature register fields as signed quantities
  ARM: advertise availability of v8 Crypto instructions

 arch/arm/include/asm/cputype.h | 16 +++++++++++++++
 arch/arm/kernel/setup.c        | 44 +++++++++++++++++++++++++++++-------------
 2 files changed, 47 insertions(+), 13 deletions(-)

-- 
1.8.3.2
