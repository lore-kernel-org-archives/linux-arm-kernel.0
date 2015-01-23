From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Fri, 23 Jan 2015 15:42:17 +0900
Subject: [PATCH -tip/urgent  0/2]kprobes bugfixes around optprobe
Message-ID: <20150123064217.30731.49156.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ingo,

Here are two patches for fixing bugs in kprobes, related to
optprobe and enable/disable kprobe knob.

These are reported and fixed by Wang Nan.
https://lkml.org/lkml/2015/1/5/270
https://lkml.org/lkml/2015/1/19/680

Thank you,


---

Wang Nan (2):
      [BUGFIX]kprobes: set kprobes_all_disarmed earlier to enable re-optimization.
      [BUGFIX]kprobes: makes kprobes/enabled works correctly for optimized kprobes.


 kernel/kprobes.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--
Masami HIRAMATSU
Software Platform Research Dpt. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
