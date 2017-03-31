From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 31 Mar 2017 10:04:49 +0100
Subject: [PATCH v5 1/9] coresight: bindings for CPU debug module
In-Reply-To: <1490466197-29163-2-git-send-email-leo.yan@linaro.org>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
 <1490466197-29163-2-git-send-email-leo.yan@linaro.org>
Message-ID: <516de455-796f-8243-7bfa-e8ff104e1945@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/03/17 18:23, Leo Yan wrote:
> According to ARMv8 architecture reference manual (ARM DDI 0487A.k)
> Chapter 'Part H: External debug', the CPU can integrate debug module
> and it can support self-hosted debug and external debug. Especially
> for supporting self-hosted debug, this means the program can access
> the debug module from mmio region; and usually the mmio region is
> integrated with coresight.
>
> So add document for binding debug component, includes binding to APB
> clock; and also need specify the CPU node which the debug module is
> dedicated to specific CPU.
>
> Suggested-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
