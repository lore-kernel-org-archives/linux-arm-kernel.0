From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Sep 2016 15:41:53 +0100
Subject: [PATCH v6 1/4] arm64: arch_timer: Add device tree binding for
 A-008585 erratum
In-Reply-To: <1474533318-7796-1-git-send-email-oss@buserror.net>
References: <1474533318-7796-1-git-send-email-oss@buserror.net>
Message-ID: <57E53F31.8000509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/09/16 09:35, Scott Wood wrote:
> This erratum describes a bug in logic outside the core, so MIDR can't be
> used to identify its presence, and reading an SoC-specific revision
> register from common arch timer code would be awkward.  So, describe it
> in the device tree.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/arch_timer.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
