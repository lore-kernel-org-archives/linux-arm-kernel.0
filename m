From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Jul 2012 21:10:24 +0100
Subject: [PATCH] ARM: fix dummy set/modify_domain() to be inline
In-Reply-To: <1341518923-20760-1-git-send-email-swarren@wwwdotorg.org>
References: <1341518923-20760-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120705201024.GC31508@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 02:08:43PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Commit 8026dbe "ARM: fix set_domain() macro" converted some macros to
> functions, but forgot to make some of the functions inline. This causes:
> 
> arch/arm/include/asm/domain.h:81:13: warning: 'set_domain' defined but not used
> arch/arm/include/asm/domain.h:82:13: warning: 'modify_domain' defined but not used
> 
> Make the functions inline to avoid this.

Already fixed.
