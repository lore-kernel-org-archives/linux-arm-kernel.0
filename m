From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Wed, 15 Aug 2012 15:47:48 +0800
Subject: [PATCH v3 2/4] dmaengine: mmp_tdma: add dt support
In-Reply-To: <201208140934.11774.arnd@arndb.de>
References: <1344917519-9505-1-git-send-email-zhangfei.gao@marvell.com>
 <1344917519-9505-3-git-send-email-zhangfei.gao@marvell.com>
 <201208140934.11774.arnd@arndb.de>
Message-ID: <CAMj5Bkjub2CUQZkse1MY_dn1CtKUmUwErYV-GQ1YYALHmWM9sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 5:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 14 August 2012, Zhangfei Gao wrote:
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>>  Documentation/devicetree/bindings/dma/mmp-dma.txt |   30 ++++++++++++
>>  drivers/dma/mmp_tdma.c                            |   51 +++++++++++++--------
>>  2 files changed, 61 insertions(+), 20 deletions(-)
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> but please add a changelog text for this patch and every other one you do.

Thanks Arnd, will take care later.
