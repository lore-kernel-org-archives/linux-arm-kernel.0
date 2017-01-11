From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed, 11 Jan 2017 16:28:35 +0000
Subject: [kvm-unit-tests PATCH 0/6] Documentation misc fixes
Message-ID: <20170111162841.15569-1-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I broke these out of my earlier MTTCG test series as they are not
strictly related. The libcflat/pci fixes are a result of trying to
cross-compile arm32 binaries on my arm64 box with a arm-none-abi
compiler. I've also tidied up some documentation (along with a
controversial move to Markdown ;-). And finally the run_script now
follows the convention of passing arguments after -- to the child
process.

Alex Benn?e (6):
  libcflat: add PRI(dux)32 format types
  lib/pci: fix BAR format strings
  docs: move README to README.md and symlink
  docs: mention checkpatch in the README
  docs: mention modifying env vars in README
  run_tests: allow passing of options to QEMU

 Makefile               |  1 +
 README                 | 69 +-----------------------------------
 README.md              | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++
 configure              | 13 +++++++
 lib/libcflat.h         |  9 +++++
 lib/pci.c              |  4 +--
 run_tests.sh           | 13 +++++--
 scripts/functions.bash |  7 ++--
 8 files changed, 137 insertions(+), 75 deletions(-)
 mode change 100644 => 120000 README
 create mode 100644 README.md

-- 
2.11.0
