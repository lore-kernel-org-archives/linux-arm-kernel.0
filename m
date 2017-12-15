From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Dec 2017 15:39:49 +0000
Subject: [PATCH 06/10] arm64: handle 52-bit physical addresses in page
 table entries
In-Reply-To: <1513184845-8711-7-git-send-email-kristina.martsenko@arm.com>
References: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
 <1513184845-8711-7-git-send-email-kristina.martsenko@arm.com>
Message-ID: <ee09c1c0-c3b6-1681-c4ec-33eb83e020d3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/17 17:07, Kristina Martsenko wrote:
> The top 4 bits of a 52-bit physical address are positioned at bits
> 12..15 of a page table entry. Introduce macros to convert between a
> physical address and its placement in a table entry, and change all
> macros/functions that access PTEs to use them.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
