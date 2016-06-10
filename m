From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Jun 2016 04:40:03 -0700
Subject: [PATCH 4/5] ARM: dts: omap5: add fref_xtal_ck support
In-Reply-To: <1464802526-16372-5-git-send-email-t-kristo@ti.com>
References: <1464802526-16372-1-git-send-email-t-kristo@ti.com>
 <1464802526-16372-5-git-send-email-t-kristo@ti.com>
Message-ID: <20160610114003.GG22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160601 10:37]:
> The clock is directly sourced from sys_clkin, and provides an external
> output clock for (typically) TWL6040 chip.

Can this patch be applied separately without issues?

Tony
