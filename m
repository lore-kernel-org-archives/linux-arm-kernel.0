From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 1 Mar 2013 10:21:32 +0000
Subject: [PATCH V2] arm64: add support for 8250/16550 earlyprintk
In-Reply-To: <1362127307-7986-1-git-send-email-anup.patel@linaro.org>
References: <1362127307-7986-1-git-send-email-anup.patel@linaro.org>
Message-ID: <20130301102132.GA1515@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 01, 2013 at 08:41:47AM +0000, Anup Patel wrote:
> This patch adds support for using earlyprintk with 8250/16550 UART
> ports.
> 
> The 8250/16550 UART can either have 8-bit or 32-bit aligned registers
> which is HW vendor dependent.
> 
> Kernel args for 8-bit aligned regs: earlyprintk=uart8250-8bit,<phys_address>
> 
> Kernel args for 32-bit aligned regs: earlyprintk=uart8250-32bit,<phys_address>
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>

Thanks. I'll queue it for 3.10.

-- 
Catalin
