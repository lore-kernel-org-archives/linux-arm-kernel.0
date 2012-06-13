From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Wed, 13 Jun 2012 22:01:55 +0800
Subject: [alsa-devel] [PATCH v2 0/5] mmp audio support
In-Reply-To: <20120613121743.GN4545@opensource.wolfsonmicro.com>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
 <20120613121743.GN4545@opensource.wolfsonmicro.com>
Message-ID: <CAMj5BkiOtgc1rPb1usHCahna8V_2PJceh9v9SGBduzChKjqoEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 8:17 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 11, 2012 at 06:04:36PM +0800, Zhangfei Gao wrote:
>
>> These patches provide mmp audio support under alsa via dmaengine
>> Support platfrom pxa688 and pxa910
>> mmp_tdma.c and mmp-pcm.c is shared for pxa688 and pxa910
>> pxa688 (mmp2) use mmp2-sspa.c
>> pxa910 directly use pxa-ssp.c
>> mmp_tdma.c is under dmaengine framework
>
> Applied 2-4. ?I'm not seeing a direct code dependency between this and
> the dmaengine driver in patch 1 (or review of it from Vinod yet) so I'm
> expecting that to go via the dmaengine tree.

Great, thanks Mark.
By the way, patch 05 "ASoC: add ttc-dkb machine support" also based on
these patches.
ttc-dkb (pxa910) and brownstone (pxa688) are sharing mmp-pcm.c and mmp-tdma.c.
