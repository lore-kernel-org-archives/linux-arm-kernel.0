From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 30 Jan 2014 11:41:33 +0000
Subject: [PATCH v2] ARM: mm: Fix stage-2 device memory attributes
In-Reply-To: <1390944264-3435-1-git-send-email-christoffer.dall@linaro.org>
References: <1390944264-3435-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <20140130114133.GL30161@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 09:24:24PM +0000, Christoffer Dall wrote:
> The stage-2 memory attributes are distinct from the Hyp memory
> attributes and the Stage-1 memory attributes.  We were using the stage-1
> memory attributes for stage-2 mappings causing device mappings to be
> mapped as normal memory.  Add the S2 equivalent defines for memory
> attributes and fix the comments explaining the defines while at it.
> 
> Add a prot_pte_s2 field to the mem_type struct and fill out the field
> for device mappings accordingly.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
