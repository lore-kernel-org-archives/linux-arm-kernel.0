From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 2 Feb 2018 11:50:58 +0530
Subject: [PATCH v6 17/41] dt-bindings: clock: Add bindings for DA8XX
 CFGCHIP clocks
In-Reply-To: <1516468460-4908-18-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-18-git-send-email-david@lechnology.com>
Message-ID: <572e31a2-ac18-512b-03bb-82fffcf4d228@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
> +EMIFA clock source (ASYNC1)
> +---------------------------
> +Required properties:
> +- compatible: shall be "ti,da850-async1-clksrc".
> +- #clock-cells: from common clock binding; shall be set to 0.
> +- clocks: phandles to the parent clocks corresponding to clock-names
> +- clock-names: shall be "pll0_sysclk3", "div4.5"

Is this clock really referred to as aysnc1 in documentation? I don't get
hits for async1 in OMAP-L138 TRM.

Thanks,
Sekhar
