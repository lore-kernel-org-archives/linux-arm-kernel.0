From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 Nov 2014 17:27:33 +0000
Subject: [PATCH v5] arm: Support for the PXN CPU feature on ARMv7
In-Reply-To: <1417189491-4619-1-git-send-email-js07.lee@gmail.com>
References: <1417189491-4619-1-git-send-email-js07.lee@gmail.com>
Message-ID: <20141128172733.GB32393@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 03:44:51PM +0000, Jungseung Lee wrote:
> Modern ARMv7-A/R cores optionally implement below new
> hardware feature:
> 
> - PXN:
> Privileged execute-never(PXN) is a security feature. PXN bit
> determines whether the processor can execute software from
> the region. This is effective solution against ret2usr attack.
> On an implementation that does not include the LPAE, PXN is
> optionally supported.
> 
> This patch set PXN bit on user page table for preventing
> user code execution with privilege mode.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Jungseung Lee <js07.lee@gmail.com>

The patch looks fine to me. Unless there are other objections, you can
send it to Russell's patch system:

http://www.arm.linux.org.uk/developer/patches/

-- 
Catalin
