From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Jun 2010 15:48:16 +0100
Subject: [PATCH 3/3] ARM: module - additional unwind tables for
	exit/devexit sections
In-Reply-To: <1275567442-11370-4-git-send-email-ext-phil.2.carmody@nokia.com>
References: <1275567442-11370-4-git-send-email-ext-phil.2.carmody@nokia.com>
Message-ID: <1276181296.24535.51.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-06-03 at 13:17 +0100, Phil Carmody wrote:
> Without these, exit functions cannot be stack-traced, so to speak.
> This implies that module unloads that perform allocations (don't
> laugh) will cause noisy warnings on the console when kmemleak is
> enabled, as it presumes that all code's call chains are traceable.
> Similarly, BUGs and WARN_ONs will give additional console spam.
> 
> Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
