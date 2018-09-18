From: lkundrak@v3.sk (Lubomir Rintel)
Date: Tue, 18 Sep 2018 22:54:51 +0200
Subject: [PATCH v2 0/4] Enable the timer clock on DT MMP2
Message-ID: <20180918205455.25464-1-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the timer work for me on an OLPC XO 1.75, which is a
device-tree based MMP2 platform.

Compared to v1 patch set, this makes the clock optional to keep compatibility
with older device trees or platforms with a compatible timer that don't seem
to require the clock.

Lubomir Rintel (4):
      dt-bindings: mrvl,mmp-timer: add clock
      DT: marvell,mmp2: add clock to the timer
      ARM: mmp2: initialize clocks before the timer
      ARM: mmp/mmp2: dt: enable the clock

Thanks,
Lubo
