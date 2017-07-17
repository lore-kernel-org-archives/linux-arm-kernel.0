From: cosardindar@gmail.com (Cosar Dindar)
Date: Mon, 17 Jul 2017 11:26:39 +0300
Subject: [RESEND,PATCH v4 0/2] Add support for the STM32F4 CRC32
Message-ID: <1500279999-46120-1-git-send-email-cosardindar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add hardware CRC32 ("Ethernet") calculation support
for STMicroelectronics STM32F429.

Polynomial and key setting are not supported, key is fixed as 0x4C11DB7
and poly is 0xFFFFFFFF.

Module is tested on STM32F429-disco board with crypto testmgr using
cases within the key 0xFFFFFFFF.

Changes in v4:
  - Edited patchset brief.

Cosar Dindar (2):
  dt-bindings : Document the STM32F4 CRC32 binding
  crypto : stm32 - Add STM32F4 CRC32 support
