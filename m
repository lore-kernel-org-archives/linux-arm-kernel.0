From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Sun, 14 Jan 2018 22:49:37 +0900
Subject: [RESEND PATCH 0/2] selftests: ftrace: Fix multiple-kprobe testcase
Message-ID: <151593777761.23875.10360397710751679883.stgit@devbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches are fixing a bug and improve testcase to
ensure adding 256 kprobe events for test.

I've just updated to the latest kselftest/master branch.

Thank you,

---

Masami Hiramatsu (2):
      [BUGFIX] selftest: ftrace: Fix to pick text symbols for kprobes
      selftest: ftrace: Fix to add 256 kprobe events correctly


 .../ftrace/test.d/kprobe/multiple_kprobes.tc       |   21 +++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
