From: tj@kernel.org (Tejun Heo)
Date: Tue, 13 Jan 2015 15:56:57 -0500
Subject: [PATCH] ata: pata_at91: depend on !ARCH_MULTIPLATFORM
In-Reply-To: <1421173517-21246-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421173517-21246-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150113205657.GF9489@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 07:25:17PM +0100, Alexandre Belloni wrote:
> Until the driver is corrected to stop using mach/at91isam9_smc.h, it won't
> compile in a ARCH_MULTIPLATFORM configuration.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Applied to libata/for-3.19-fixes.

Thanks.

-- 
tejun
