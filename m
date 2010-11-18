From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Nov 2010 10:59:43 +0000
Subject: [PATCH 3/5] ARM: pgtable: introduce pteval_t to represent a pte
	value
In-Reply-To: <E1PIlop-0007qc-1e@rmk-PC.arm.linux.org.uk>
References: <20101117172717.GF5308@n2100.arm.linux.org.uk>
	<E1PIlop-0007qc-1e@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTikchj6kVRRN8RgjzCsELneZjM7MPtYEhB4ULQdX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 November 2010 17:29, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This makes everywhere dealing with pte values use the same type.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?arch/arm/include/asm/page.h ? ?| ? ?6 ++++--
> ?arch/arm/include/asm/pgtable.h | ? 39 ++++++++++++++++++++-------------------

Do we need to adjust the type of the mask in pte_modify?

-- 
Catalin
