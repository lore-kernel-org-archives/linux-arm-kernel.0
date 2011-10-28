From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 28 Oct 2011 23:38:50 +0200
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <1319813059-8914-2-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
Message-ID: <20111028213850.GB7961@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:43 Fri 28 Oct     , Will Deacon wrote:
> arch_reset is a static inline function defined in mach/system.h and, as
> such, is a blocker for the single zImage work.
> 
> This patch introduces an arm_arch_reset function pointer to which
> platforms can assign their reset function rather than define it in the
> header file.
this is a great cleanup but I think this should be done in the soc_desc
structure as propose before

Best Regards,
J.
