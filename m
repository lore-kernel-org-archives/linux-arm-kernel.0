From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Tue, 22 Nov 2016 18:14:09 +0100
Subject: [PATCH 0/2] serial: introduce DSR handling property
Message-ID: <1479834851-32442-1-git-send-email-chf.fritz@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces device-tree property "disable-dsr" including
documentation and usage.

Christoph Fritz (2):
  doc: DT: add generic serial property to disable DSR
  serial: imx: make DSR irq handling conditional

 Documentation/devicetree/bindings/serial/serial.txt | 2 ++
 drivers/tty/serial/imx.c                            | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.1.4
