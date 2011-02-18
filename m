From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Feb 2011 11:15:47 +0000
Subject: [PATCH 00/10] Fix CLCD framebuffer formats and consolidate ARM
	platform CLCD support
In-Reply-To: <20110127125714.GD25968@n2100.arm.linux.org.uk>
References: <20110127125714.GD25968@n2100.arm.linux.org.uk>
Message-ID: <1298027747.11711.37.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-01-27 at 12:57 +0000, Russell King - ARM Linux wrote:
> This patch series fixes the framebuffer formatting for the various
> CLCD colour modes - including those which the CLCD doesn't actually
> support.

I reviewed the patches and they look fine (ack if you want).

What I can't tell for sure is whether the capabilities supported by the
displays are correct (platforms people here in ARM should know better
but I don't think we have all those available to try).

-- 
Catalin
