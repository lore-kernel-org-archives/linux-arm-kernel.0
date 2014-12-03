From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 Dec 2014 10:32:11 +0000
Subject: Creating 16 MB super-sections for MMIO
In-Reply-To: <547EDD61.5080907@free.fr>
References: <547D97A5.4090302@free.fr>
 <547EDD61.5080907@free.fr>
Message-ID: <20141203103211.GB7373@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 09:52:33AM +0000, Mason wrote:
> [Top-posting to address topicality]
> 
> Is LKML more appropriate a list to discuss MMU setup?
> (I've been studying arch-specific code in arch/arm/mm)

The list is fine. The reasons behind this proposal aren't clear. Are you
trying to optimise mmio register accesses by avoiding TLB misses?

-- 
Catalin
