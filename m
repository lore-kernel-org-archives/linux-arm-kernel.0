From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Apr 2014 11:45:07 +0200
Subject: [PATCH 02/27] ARM: EXYNOS: Add IO mapping for non-secure SYSRAM
 of Exynos3250
In-Reply-To: <1397122124-15690-3-git-send-email-cw00.choi@samsung.com>
References: <1397122124-15690-1-git-send-email-cw00.choi@samsung.com>
 <1397122124-15690-3-git-send-email-cw00.choi@samsung.com>
Message-ID: <4172202.teSeEmypAU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 April 2014 18:28:19 Chanwoo Choi wrote:
> 
> The non-secure SYSRAM is used for secondary CPU bring-up. This patch add
> IO mapping for non-scure SYSRAM.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

I really don't want to see any further static mappings here. We had the
same discussion for the previous Exynos chip that was submitted, so please
describe the SYSRAM in DT, and start thinking about the other static mappings
that can be removed.

	Arnd
