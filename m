From: robh@kernel.org (Rob Herring)
Date: Fri, 3 Mar 2017 00:21:24 -0600
Subject: [PATCH v2 1/3] coresight: bindings for debug module
In-Reply-To: <1488294420-14188-2-git-send-email-leo.yan@linaro.org>
References: <1488294420-14188-1-git-send-email-leo.yan@linaro.org>
 <1488294420-14188-2-git-send-email-leo.yan@linaro.org>
Message-ID: <20170303062124.rc2fw6axs3cp7ofc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 11:06:58PM +0800, Leo Yan wrote:
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
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../devicetree/bindings/arm/coresight-debug.txt    | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/coresight-debug.txt

Acked-by: Rob Herring <robh@kernel.org>
