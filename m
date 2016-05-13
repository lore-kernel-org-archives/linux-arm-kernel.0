From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Fri, 13 May 2016 03:03:36 +0000
Subject: [PATCH v4 02/18] arc: Remove unnecessary of_platform_populate
 with default match table
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
 <1463054775-18170-3-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4EA216B@us01wembx1.internal.synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 May 2016 05:32 PM, Kefeng Wang wrote:
> After patch "of/platform: Add common method to populate default bus",
> it is possible for arch code to remove unnecessary callers about the
> of_platform_populate with default match table.
>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Vineet Gupta <vgupta@synopsys.com>
