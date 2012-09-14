From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 14 Sep 2012 10:58:07 +0800
Subject: [PATCH v5 3/3] ARM: dt: mmp-dma: add binding file
In-Reply-To: <1347590720.1943.0.camel@vkoul-udesk3>
References: <1346641427-5002-1-git-send-email-zhangfei.gao@marvell.com>
 <1346641427-5002-4-git-send-email-zhangfei.gao@marvell.com>
 <1347590720.1943.0.camel@vkoul-udesk3>
Message-ID: <CAN1soZwu6LPOL4f3x7d31QPyox4a9gQ4GU0SKSMF7bH=Q=Z87w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 10:45 AM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Mon, 2012-09-03 at 11:03 +0800, Zhangfei Gao wrote:
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Vinod Koul <vinod.koul@linux.intel.com>
>
> I think this patch should be merged in tree having this file, possibly
> arm tree?
>

You can merge this patch into your tree since it only appends a new file.

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Regards
Haojian
>> ---
>>  Documentation/devicetree/bindings/dma/mmp-dma.txt |   75 +++++++++++++++++++++
>>  1 files changed, 75 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/dma/mmp-dma.txt
>>
