From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 6 Mar 2012 17:12:18 +0800
Subject: [PATCH] ARM: pxa: fix build failure for regulator consumer in
 em-x270.c
In-Reply-To: <4F55CEDB.90909@compulab.co.il>
References: <1330989122-6323-1-git-send-email-paul.gortmaker@windriver.com>
 <4F55CEDB.90909@compulab.co.il>
Message-ID: <CAN1soZxdT=N1BtK5Jf4+Qu3GGCHPuKK1BqgfEV-D7QorjnsLpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2012 at 4:46 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> Also Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
>
> On 03/06/12 01:12, Paul Gortmaker wrote:
>> Commit 737f360d5bef5e01c6cfa755dca0b449a154c1e0 (linux-next)
>>
>> ? "regulator: Remove support for supplies specified by struct device"
>>
>> caused this file to break, since it was still relying on the
>> device field to be present. ?Strip them out here too.
>>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> You've missed the scissors line:
> ---
>
> The patch itself:
>
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>
>
> Thanks
>

Mark,

Could you pick up this patch since it's depend on latest change on regulator?

Best Regards
Haojian
