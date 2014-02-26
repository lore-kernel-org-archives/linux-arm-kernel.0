From: mohun106@gmail.com (mohun106 at gmail.com)
Date: Wed, 26 Feb 2014 11:28:29 +0530
Subject: [RFC PATCH 0/1] arm64: 48-bit Physical Address support
Message-ID: <1393394310-6138-1-git-send-email-mohun106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

This patch adds support for ARMv8 platforms that have 48-bit Physical
Address implemented. The number of levels for translating VA to PA has
not changed.

Radha Mohan Chintakuntla (1):
  arm64: Add support for 48-bit Physical Address

 arch/arm64/Kconfig                     |    3 +++
 arch/arm64/include/asm/kvm_arm.h       |    9 ++++++++-
 arch/arm64/include/asm/pgtable-hwdef.h |   15 +++++++++++++++
 arch/arm64/mm/proc.S                   |    2 +-
 4 files changed, 27 insertions(+), 2 deletions(-)
