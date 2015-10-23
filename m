From: vdonnefort@gmail.com (Vincent Donnefort)
Date: Fri, 23 Oct 2015 12:59:57 +0200
Subject: [PATCH v6] ARM: mvebu: add broken-idle option
In-Reply-To: <87oafq2f0m.fsf@free-electrons.com>
References: <87oafq2f0m.fsf@free-electrons.com>
Message-ID: <1445597998-23751-1-git-send-email-vdonnefort@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

changes for v6:
- broken_idle() returns 1 when broken.

Vincent Donnefort (1):
  ARM: mvebu: add broken-idle option

 .../devicetree/bindings/arm/coherency-fabric.txt   |  5 ++++
 arch/arm/mach-mvebu/pmsu.c                         | 29 +++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

-- 
2.1.4
