From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 13 Jul 2015 23:20:35 +0800
Subject: [PATCH] arm:irqchip: IRQCHIP_DECLARE macro is now accessible
In-Reply-To: <1436299411-12329-1-git-send-email-joel@porquet.org>
References: <1436299411-12329-1-git-send-email-joel@porquet.org>
Message-ID: <20150713152035.GD26642@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 04:02:53PM -0400, Joel Porquet wrote:
> The IRQCHIP_DECLARE macro migrated to 'include/linux/irqchip.h', making it
> globally accessible.
> 
> See commit 91e20b5040c67c51aad88cf87db4305c5bd7f79d
> ("irqchip: Move IRQCHIP_DECLARE macro to include/linux/irqchip.h").
> 
> This patch adds inclusions of 'include/linux/irqchip.h' and replaces uses of
> macro OF_DECLARE_2 with IRQCHIP_DECLARE.
> 
> Signed-off-by: Joel Porquet <joel@porquet.org>
> ---
...
>  arch/arm/mach-imx/gpc.c              | 7 ++-----

Acked-by: Shawn Guo <shawnguo@kernel.org>

How will this patch be sent to upstream?

Shawn
