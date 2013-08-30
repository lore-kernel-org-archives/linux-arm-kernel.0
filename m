From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 30 Aug 2013 11:17:08 -0500
Subject: [Patch v3 2/3] ARM: dts: Document the CCI PMU DT bindings
In-Reply-To: <1377183748-5717-3-git-send-email-punit.agrawal@arm.com>
References: <1377183748-5717-1-git-send-email-punit.agrawal@arm.com>
 <1377183748-5717-3-git-send-email-punit.agrawal@arm.com>
Message-ID: <938AAABA-BE7E-48ED-82D6-61A35B6D9774@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 22, 2013, at 10:02 AM, Punit Agrawal wrote:

> The CCI PMU can profile bus transactions at the master and slave
> interfaces of the CCI. The PMU can be used to observe an aggregated
> view of the bus traffic between the various components connected to the
> CCI.
> 
> Introduce a binding for the CCI PMU. The PMU node will be a sub-node of
> the CCI node.
> 
> Cc: devicetree at vger.kernel.org
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
> Documentation/devicetree/bindings/arm/cci.txt |   46 +++++++++++++++++++++++++
> 1 file changed, 46 insertions(+)

Acked-by: Kumar Gala <galak@codeaurora.org>

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
