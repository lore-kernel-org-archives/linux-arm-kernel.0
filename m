From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 22 Aug 2013 16:17:40 -0600
Subject: [Patch v3 2/3] ARM: dts: Document the CCI PMU DT bindings
In-Reply-To: <1377183748-5717-3-git-send-email-punit.agrawal@arm.com>
References: <1377183748-5717-1-git-send-email-punit.agrawal@arm.com>
 <1377183748-5717-3-git-send-email-punit.agrawal@arm.com>
Message-ID: <52168E04.5020406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2013 09:02 AM, Punit Agrawal wrote:
> The CCI PMU can profile bus transactions at the master and slave
> interfaces of the CCI. The PMU can be used to observe an aggregated
> view of the bus traffic between the various components connected to the
> CCI.
> 
> Introduce a binding for the CCI PMU. The PMU node will be a sub-node of
> the CCI node.

This also seems fine to me.
Acked-by: Stephen Warren <swarren@nvidia.com>
