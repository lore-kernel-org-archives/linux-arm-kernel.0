From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed, 11 Jan 2017 16:28:40 +0000
Subject: [kvm-unit-tests PATCH 5/6] docs: mention modifying env vars in README
In-Reply-To: <20170111162841.15569-1-alex.bennee@linaro.org>
References: <20170111162841.15569-1-alex.bennee@linaro.org>
Message-ID: <20170111162841.15569-6-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I had started adding a series of flags to control the run-time
behaviour of the tests but it was pointed out env vars can already do
that. Mention them in the README so others can find out to.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
---
 README.md | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/README.md b/README.md
index 9462824..fa3a445 100644
--- a/README.md
+++ b/README.md
@@ -47,6 +47,14 @@ environment variable:
 
     QEMU=/tmp/qemu/x86_64-softmmu/qemu-system-x86_64 ./x86-run ./x86/msr.flat
 
+To force the acceleration mode:
+
+    ACCEL=tcg ./run_tests.sh
+
+To extend or disable the timeouts:
+
+    TIMEOUT=0 ./run_tests.sh
+
 # Contributing
 
 ## Directory structure
-- 
2.11.0
