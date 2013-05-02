From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 2 May 2013 11:05:08 +0100
Subject: [RFC PATCH 8/9] ARM64: mm: Introduce MAX_ZONE_ORDER for 64K
 and THP.
In-Reply-To: <20130502100000.GB20730@arm.com>
References: <1367339448-21727-1-git-send-email-steve.capper@linaro.org>
 <1367339448-21727-9-git-send-email-steve.capper@linaro.org>
 <20130502100000.GB20730@arm.com>
Message-ID: <20130502100507.GA19880@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 11:00:00AM +0100, Catalin Marinas wrote:
> On Tue, Apr 30, 2013 at 05:30:47PM +0100, Steve Capper wrote:
 
> Can we just keep some sane defaults here without giving too much choice
> to the user? Something like:
> 
> config FORCE_MAX_ZONEORDER
> 	int
> 	default "13" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
> 	default "11"
> 
> We can extend it later if people need this but I'm aiming for a single
> config on a multitude of boards.
> 
> -- 
> Catalin

Thanks, that does look a lot neater :-).

-- 
Steve
