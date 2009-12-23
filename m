From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 23 Dec 2009 13:42:32 -0500
Subject: [PATCH 0/2] arm: add a /proc/cpuinfo platform extension
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200F377@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an optional platform specific extension to /proc/cpuinfo.

Many platforms have custom cpu information that could be exposed
to user space using /proc/cpuinfo.

Patch 1/2 adds the necessary core support to allow a platform
specific callback to dump this information.

Patch 2/2 adds a callback to mach-ep93xx and hooks up all the
edb93xx platforms.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
