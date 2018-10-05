From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 5 Oct 2018 17:55:52 +0100
Subject: [PATCH] MAINTAINERS: fix bad sdei paths
In-Reply-To: <20181005142120.13279-1-james.morse@arm.com>
References: <20181005142120.13279-1-james.morse@arm.com>
Message-ID: <20181005165552.6ta4qjioexn3ea4v@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2018 at 03:21:20PM +0100, James Morse wrote:
> The SDEI header files had an 'arm_' namespace added, but the patterns
> in the MAINTAINERS files were missed. Oops.
> 
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> The SDEI stuff originally went via arm64, ... what about this?

I'll queue this patch for 4.20.

-- 
Catalin
