From: mkl0301@gmail.com (Mac Lin)
Date: Fri, 29 Mar 2013 17:13:01 +0800
Subject: [PATCH 0/2] fix cns3xxx booting issue
Message-ID: <CAK1hUK9khvggwc_yaQUu61bTLaHZiAFowFGC-BH98Tp0zFaXZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anton,

I'm sorry that I cannot send the patches via send-patch, nor can I
make a new one now.
So I'll copy-paste the result of format-patch. (I'm working on an
unsupported Ubuntu.....)

> I have my code pushed to https://github.com/mkl0301/linux.git, branch
> cns3v20vb-3.9-multiplatform-test, in case you need them.

Mac Lin (2):
      ARM: cns3xxx: remove unused virtual address and iotable defines
      ARM: cns3xxx: fix mapping of private memory region

 arch/arm/mach-cns3xxx/cns3xxx.h |   43 +++++++-------------------------------
 arch/arm/mach-cns3xxx/core.c    |   26 ++--------------------
 2 files changed, 11 insertions(+), 58 deletions(-)

Best Regards,
Mac Lin
