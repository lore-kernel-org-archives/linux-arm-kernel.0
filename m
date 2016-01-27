From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Wed, 27 Jan 2016 07:56:07 +0000
Subject: [PATCH 04/15] arc: use of_platform_default_populate() to
 populate default bus
References: <1453868872-26300-1-git-send-email-wangkefeng.wang@huawei.com>
 <1453868872-26300-5-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E86CE2@us01wembx1.internal.synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 January 2016 09:56 AM, Kefeng Wang wrote:
> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

Acked-by: Vineet Gupta <vgupta@synopsys.com>

Thx,
-Vineet
