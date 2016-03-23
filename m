From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 23 Mar 2016 14:43:38 +0000
Subject: [PATCH v2 0/5] mailbox: A few fixes due for the v4.6 -rcs
Message-ID: <1458744223-12164-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

Resending these with patches 1 and 2 merged, as requested.

Kind regards,
Lee

v1 => v2:
  - Patch 2 merged into patch 
  - No functional changes

Lee Jones (5):
  ARM: STi: stih407-family: Add nodes for Mailbox
  ARM: STi: DT: STiH407: Enable Mailbox testing facility
  mailbox: mailbox-test: Use more consistent format for calling
    copy_from_user()
  mailbox: mailbox-test: Prevent memory leak
  mailbox: Stop using ENOSYS for anything other than unimplemented
    syscalls

 arch/arm/boot/dts/stih407-family.dtsi | 39 +++++++++++++++++++++++++++++++++++
 drivers/mailbox/mailbox-test.c        | 16 +++++++-------
 drivers/mailbox/mailbox.c             |  4 ++--
 3 files changed, 50 insertions(+), 9 deletions(-)

-- 
1.9.1
