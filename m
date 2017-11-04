From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Sat,  4 Nov 2017 13:30:22 +0900
Subject: [PATCH -next 0/2] arm: kprobes: Remove jprobe test case
Message-ID: <150976982219.2012.12861503668350308669.stgit@devbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series fixes a typo and remove jprobe test case
because jprobe is deprecated feature. The typo is
related to jprobe so need to be fixed in this series.

Thank you,

---

Masami Hiramatsu (2):
      arm: kprobes: Fix kretprobe test to check correct counter
      arm: kprobes: Remove jprobe test case


 arch/arm/probes/kprobes/test-core.c |   59 +----------------------------------
 1 file changed, 1 insertion(+), 58 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
