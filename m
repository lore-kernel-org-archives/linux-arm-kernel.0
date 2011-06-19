From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 19 Jun 2011 12:54:52 -0400
Subject: [PATCH 0/2] kuser helpers documentation cleanup and 64-bit cmpxchg
Message-ID: <1308502494-20938-1-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series cleans up the kuser documentation, then it adds 64-bit
cmpxchg support as needed by some user space applications.

[PATCH 1/2] ARM: kuser: move interface documentation out of the source code
[PATCH 2/2] ARM: add a kuser_cmpxchg64 user space helper
