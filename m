From: lznuaa@gmail.com (Frank Li)
Date: Thu, 21 Jun 2012 13:38:14 +0800
Subject: How to use ARM ETM/ETB at linux?
Message-ID: <CAHrpEqRk4SQ+8LHCOX0zwtZjnTe=k0c_GCJMqvYMZBUa-dJq=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Anyone use ARM ETM/ETB before?

I run.
echo 1 > /sys/devices/etm/trace_running

root at freescale /$ echo v >/proc/sysrq-trigger
SysRq : etm
Trace buffer contents length: 4
--- ETB buffer begin ---
01000000000000000000000000000000

--- ETB buffer end ---


best regards
Frank Li
