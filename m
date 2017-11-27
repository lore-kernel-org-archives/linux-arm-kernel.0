From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Mon, 27 Nov 2017 18:53:09 +0900
Subject: [PATCH 0/2] selftests: ftrace: Fix multiple-kprobe testcase
Message-ID: <151177638973.11564.2545351695862460866.stgit@devbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches are fixing a bug and improve testcase to
ensure adding 256 kprobe events for test.

The 1st patch is clearly a bug, so it should be fixed
in stable kernel too.

Thank you,

---

Masami Hiramatsu (2):
      [BUGFIX] selftest: ftrace: Fix to pick text symbols for kprobes
      selftest: ftrace: Fix to add 256 kprobe events correctly


 .../ftrace/test.d/kprobe/multiple_kprobes.tc       |   21 +++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
