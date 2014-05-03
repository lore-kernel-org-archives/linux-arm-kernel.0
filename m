From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 May 2014 18:03:11 -0700
Subject: [PATCH v5 1/8] mfd: AXP20x: Add mfd driver for AXP20x PMIC
In-Reply-To: <1398947374-3115-2-git-send-email-carlo@caione.org>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-2-git-send-email-carlo@caione.org>
Message-ID: <20140503010311.GD4090@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 01, 2014 at 02:29:27PM +0200, Carlo Caione wrote:
> This patch introduces the preliminary support for PMICs X-Powers AXP202
> and AXP209. The AXP209 and AXP202 are the PMUs (Power Management Unit)
> used by A10, A13 and A20 SoCs and developed by X-Powers, a sister company
> of Allwinner.
> 
> The core enables support for two subsystems:
> - PEK (Power Enable Key)
> - Regulators
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140502/06eaa45b/attachment.sig>
