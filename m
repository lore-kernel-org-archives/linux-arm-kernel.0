From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Aug 2012 02:04:52 -0700
Subject: [PATCH v2 04/31] arm64: MMU definitions
In-Reply-To: <1344966752-16102-5-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-5-git-send-email-catalin.marinas@arm.com>
Message-ID: <20120817090451.GP11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Catalin Marinas <catalin.marinas@arm.com> [120814 10:57]:
> The virtual memory layout is described in
> Documentation/arm64/memory.txt. This patch adds the MMU definitions for
> the 4KB and 64KB translation table configurations. The SECTION_SIZE is
> 2MB with 4KB page and 512MB with 64KB page configuration.
> 
> PHYS_OFFSET is calculated at run-time and stored in a variable (no
> run-time code patching at this stage).

Care to clarify this part a bit? Is the memory standardized somehow
now and not needed? Or do we still need to add that for various SoCs
later on?

Other than that:

Acked-by: Tony Lindgren <tony@atomide.com>
