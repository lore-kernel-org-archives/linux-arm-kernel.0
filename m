From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu, 23 Nov 2017 12:11:32 +0000
Subject: [PATCH v1 0/2] Additional single-step-cases
Message-ID: <20171123121134.11050-1-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is now split into two patches as the first case of SError is
separate from behaviour of stepping instructions.

Alex Benn?e (2):
  kvm: arm64: handle single-step during SError exceptions
  kvm: arm64: handle single-step of hyp emulated mmio instructions

 arch/arm64/kvm/handle_exit.c |  8 +++++++-
 arch/arm64/kvm/hyp/switch.c  | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 8 deletions(-)

-- 
2.15.0
