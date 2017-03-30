From: robh@kernel.org (Rob Herring)
Date: Thu, 30 Mar 2017 17:49:20 -0500
Subject: [PATCH v5 1/9] coresight: bindings for CPU debug module
In-Reply-To: <1490466197-29163-2-git-send-email-leo.yan@linaro.org>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
 <1490466197-29163-2-git-send-email-leo.yan@linaro.org>
Message-ID: <20170330224920.ogwoymnxlhf7d72z@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 26, 2017 at 02:23:09AM +0800, Leo Yan wrote:
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
> ---
>  .../bindings/arm/coresight-cpu-debug.txt           | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt

Acked-by: Rob Herring <robh@kernel.org>
