From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 10 Nov 2011 16:59:33 -0500 (EST)
Subject: [PATCH v8 08/16] ARM: LPAE: Page table maintenance for the 3-level
 format
In-Reply-To: <1320682618-1182-9-git-send-email-catalin.marinas@arm.com>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
 <1320682618-1182-9-git-send-email-catalin.marinas@arm.com>
Message-ID: <alpine.LFD.2.02.1111101654400.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Nov 2011, Catalin Marinas wrote:

> This patch modifies the pgd/pmd/pte manipulation functions to support
> the 3-level page table format. Since there is no need for an 'ext'
> argument to cpu_set_pte_ext(), this patch conditionally defines a
> different prototype for this function when CONFIG_ARM_LPAE.

Maybe it doesn't make sense to still call it cpu_set_pte_ext then?


Nicolas
