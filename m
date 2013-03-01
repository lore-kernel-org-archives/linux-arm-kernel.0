From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 01 Mar 2013 09:46:24 +0100
Subject: [PATCH V2] arm64: add support for 8250/16550 earlyprintk
In-Reply-To: <1362127307-7986-1-git-send-email-anup.patel@linaro.org>
References: <1362127307-7986-1-git-send-email-anup.patel@linaro.org>
Message-ID: <8a607bb68e491a3733413acd5843cfc1@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  1 Mar 2013 14:11:47 +0530, Anup Patel <anup.patel@linaro.org>
wrote:
> This patch adds support for using earlyprintk with 8250/16550 UART
ports.
> 
> The 8250/16550 UART can either have 8-bit or 32-bit aligned registers
> which is HW vendor dependent.
> 
> Kernel args for 8-bit aligned regs:
> earlyprintk=uart8250-8bit,<phys_address>
> 
> Kernel args for 32-bit aligned regs:
> earlyprintk=uart8250-32bit,<phys_address>
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>

Looks OK to me. FWIW:

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
-- 
Fast, cheap, reliable. Pick two.
