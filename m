From: vincent.stehle@freescale.com (=?UTF-8?q?Vincent=20Stehl=C3=A9?=)
Date: Wed, 3 Jul 2013 10:12:57 +0200
Subject: linux-next arm multi_v7_defconfig: add support for i.MX6 on NFS root
Message-ID: <1372839179-14542-1-git-send-email-vincent.stehle@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I would like to propose the following two patches, which allow me to boot
next-20130702 with NFS root on an i.MX6 sabre sd:

  [PATCH linux-next 1/2] arm: multi_v7_defconfig: add i.MX serial
  [PATCH linux-next 2/2] arm: multi_v7_defconfig: add support for NFS

Note that at the time of writing, a few other patches are necessary for me as
well:

- i2c-designware: use div_u64 to fix link
  https://lkml.org/lkml/2013/7/2/145

- tick: Prevent uncontrolled switch to oneshot mode
  https://lkml.org/lkml/2013/7/2/270

- tick: Sanitize broadcast control logic
  https://lkml.org/lkml/2013/7/2/272

Best regards,

V.
