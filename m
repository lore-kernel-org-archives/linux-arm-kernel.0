From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Dec 2010 20:07:46 +0000
Subject: [PATCH 0/22] More SMP cleanup
Message-ID: <20101203200746.GA10245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series incorporates patches from the previously posted
"Clean up SMP IPI support" series of 9 patches.  Patch 5, and
11 onwards are new.

This aims to reduce the amount of code in platform specific files
to the barest minimum, while maintaining the flexibility of the
API to allow platforms to decide which CPU numbers are populated.
