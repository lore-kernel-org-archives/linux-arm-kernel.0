From: geoff@infradead.org (Geoff Levand)
Date: Thu, 12 Jun 2014 00:12:56 +0000
Subject: [PATCH 0/2] arm64 bootwrapper fixes
Message-ID: <cover.1402531738.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

Here are two fixes for the arm64 bootwrapper.  The first is a critical makefile
fix, the second a minor configure fix.  Please consider.

-Geoff


The following changes since commit 09d7031d5642ff1d81c0dede9b86822d67b6b52a:

  boot-wrapper: arm64: add support for GICv3 (2014-05-09 18:43:52 +0100)

are available in the git repository at:

  git://git.linaro.org/people/geoff.levand/boot-wrapper-aarch64.git master

for you to fetch changes up to 8ad2293111bbd60ddecd071be34734c2b46415df:

  configure: Fixes for --enable-xxx (2014-06-11 17:07:54 -0700)

----------------------------------------------------------------
Geoff Levand (2):
      Makefile: Add local perl module include path
      configure: Fixes for --enable-xxx

 Makefile.am  | 14 +++++++-------
 configure.ac | 19 +++++++++----------
 2 files changed, 16 insertions(+), 17 deletions(-)

-- 
1.9.1
