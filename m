From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed,  7 Dec 2016 23:24:05 -0500
Subject: [PATCH 0/2] improve modversions for symbols exported from assembly
 code
Message-ID: <1481171047-333-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a partial repost of the patches I sent last week, without the
ARM part this time, in the hope that this can be considered for the next
merge window so that architecture specific changes can start using it
afterwards.


 include/asm-generic/export.h | 24 ++++++++++++++++++++++++
 scripts/Makefile.build       | 38 +++++++++++++++++++-------------------
 2 files changed, 43 insertions(+), 19 deletions(-)
