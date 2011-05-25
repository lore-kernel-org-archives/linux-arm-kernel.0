From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Wed, 25 May 2011 05:22:23 -0400
Subject: [PATCH v2 0/3] provide sdhci driver for mmp2 and pxa910
Message-ID: <BANLkTikyrZYZOct1ZFv8-FOJKAbyo-TwtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are patches to provide separate sdhci driver for mmp2 and pxa910
based on sdhci-platfm.
Remove sdhci-pxa.c, which is used to share among pxa serious, since
under this method, platform difference have to be put under arch/arm,
which is not easy to track.
As a result, mmp2 mmc resource should be updated accordingly.

The patches verified after Shawn's modification to sdhci-platfm.c.
