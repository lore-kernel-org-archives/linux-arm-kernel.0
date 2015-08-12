From: pratyush.anand@gmail.com (Pratyush Anand)
Date: Wed, 12 Aug 2015 21:10:20 +0530
Subject: [PATCH v6 1/6] PCI: designware: move calculation of bus addresses
 to DRA7xx
In-Reply-To: <55C44A80.20308@hisilicon.com>
References: <1438848559-232109-1-git-send-email-wangzhou1@hisilicon.com>
 <1438848559-232109-2-git-send-email-wangzhou1@hisilicon.com>
 <55C44A80.20308@hisilicon.com>
Message-ID: <CAHM4w1muj4+OBcsDQ9ePjV77t+iPh7TYY8h5MF66GjD=2ktRew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 7, 2015 at 11:34 AM, Zhou Wang <wangzhou1@hisilicon.com> wrote:
> [+cc jingoohan1 at gmail.com]
>
> On 2015/8/6 16:09, Zhou Wang wrote:
>> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>>
>> Commit f4c55c5a3f7f "PCI: designware: Program ATU with untranslated
>> address" added the calculation of PCI BUS addresses in designware,
>> storing them in new fields added in "struct pcie_port". This
>> calculation is done for every designware user even if is only
>> applicable to DRA7xx.
>> This patch moves the calculation of the bus addresses to the DRA7xx
>> driver and is needed to allow the rework of designware to use
>> the new DT parsing API.
>>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>


Looks fine to me
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
