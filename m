From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Fri, 3 Jun 2011 17:48:50 +0800
Subject: [PATCH v3 0/3] provide sdhci driver for mmp2 and pxa910
Message-ID: <BANLkTikP72ybaqa8zDgNjBQg8Q6SH5fMdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2->v3, modify according to Arnd and Philip suggestion.

Here are patches to provide separate sdhci driver for mmp2 and pxa910
based on sdhci-platfm.
Rename to sdhci-pxav3.c and sdhci-pxav2.c
Remove sdhci-pxa.c, which is used to share among pxa serious, since
under this method, platform difference have to be put under arch/arm,
which is not easy to track.
As a result, mmp2 mmc resource should be updated accordingly.
