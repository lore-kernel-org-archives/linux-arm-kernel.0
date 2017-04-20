From: robh@kernel.org (Rob Herring)
Date: Thu, 20 Apr 2017 10:57:17 -0500
Subject: [PATCH 1/2] clk: hi6220: add acpu clock
In-Reply-To: <1492478242-16146-1-git-send-email-zhangfei.gao@linaro.org>
References: <1492478242-16146-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20170420155717.mohnrg6lxpwkoytb@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 09:17:21AM +0800, Zhangfei Gao wrote:
> Add acpu clock, including sft clock controlling hi6220 coresight module
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
> ---
>  .../devicetree/bindings/clock/hi6220-clock.txt     |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/hisilicon/clk-hi6220.c                 | 23 ++++++++++++++++++++++
>  include/dt-bindings/clock/hi6220-clock.h           |  4 ++++
>  3 files changed, 28 insertions(+)
