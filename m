From: s-anna@ti.com (Suman Anna)
Date: Fri, 19 May 2017 15:47:40 -0500
Subject: [PATCH 0/2] Enable Mailboxes for AM57xx IDKs
Message-ID: <20170519204742.1563-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

This series enables the mailbox nodes to be used for communicating with
the DSPs and IPUs on AM57xx IDKs using IPC 3.x. The mailbox nodes themselves
were already defined/added before for other DRA7 boards, and these patches
simply enable the respective nodes for the IDKs.

Patches are based on 4.12-rc1 and are intended for the 4.13 merge
window.

regards
Suman

Suman Anna (2):
  ARM: dts: am572x-idk: Enable the system mailboxes 5 and 6
  ARM: dts: am571x-idk: Enable the system mailboxes 5 and 6

 arch/arm/boot/dts/am571x-idk.dts | 17 +++++++++++++++++
 arch/arm/boot/dts/am572x-idk.dts | 20 ++++++++++++++++++++
 2 files changed, 37 insertions(+)

-- 
2.12.0
