From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 17 May 2017 09:31:36 +0800
Subject: [PATCH 1/2] clk: hi6220: add acpu clock
In-Reply-To: <20170420155717.mohnrg6lxpwkoytb@rob-hp-laptop>
References: <1492478242-16146-1-git-send-email-zhangfei.gao@linaro.org>
 <20170420155717.mohnrg6lxpwkoytb@rob-hp-laptop>
Message-ID: <0e1a391e-cec5-1e94-c491-1c816eca85c3@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017?04?20? 23:57, Rob Herring wrote:
> On Tue, Apr 18, 2017 at 09:17:21AM +0800, Zhangfei Gao wrote:
>> Add acpu clock, including sft clock controlling hi6220 coresight module
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
>> ---
>>   .../devicetree/bindings/clock/hi6220-clock.txt     |  1 +
> Acked-by: Rob Herring <robh@kernel.org>

Thanks Rob

Btw, have tested on 4.12-rc1, the patches can be applied directly.
