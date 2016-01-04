From: mst@redhat.com (Michael S. Tsirkin)
Date: Mon, 4 Jan 2016 13:36:44 +0200
Subject: [PATCH 0/3] checkpatch: handling of memory barriers
Message-ID: <1451907395-15978-1-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of memory barrier cleanup, this patchset
extends checkpatch to make it easier to stop
incorrect memory barrier usage.

This applies on top of my series
	arch: barrier cleanup + barriers for virt
and will be included in the next version of the series.

Michael S. Tsirkin (3):
  checkpatch.pl: add missing memory barriers
  checkpatch: check for __smp outside barrier.h
  checkpatch: add virt barriers

 scripts/checkpatch.pl | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

-- 
MST
