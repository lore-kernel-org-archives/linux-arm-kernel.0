From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Mon, 18 Jul 2011 12:22:08 +0530
Subject: [PATCH 0/3] ARM: USB: Add support for USB HCD on PXA168
Message-ID: <1310971931-4825-1-git-send-email-tanmay.upadhyay@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for on-chip EHCI USB host controller on
PXA168. The patches depends on patch series that adds support for gplugD
[1] & a couple of fixes[2,3] followed by the same. All of these[1, 2, 3]
are accepted by Eric Miao <eric.y.miao@gmail.com>.

Patches in this series are based on Linux 2.6.39-rc4

[1] http://lists.arm.linux.org.uk/lurker/message/20110502.055957.4236c42a.en.html
[2] http://lists.arm.linux.org.uk/lurker/message/20110714.093715.f1b7c910.en.html
[3] http://lists.arm.linux.org.uk/lurker/message/20110714.093716.615ae7dd.en.html
