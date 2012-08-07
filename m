From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 07 Aug 2012 15:22:47 +0200
Subject: [PATCH] ARM: dma-mapping: fix atomic allocation alignment
In-Reply-To: <1344187926-22404-1-git-send-email-aaro.koskinen@iki.fi>
References: <1344187926-22404-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <011d01cd749f$be649fa0$3b2ddee0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Aaro,

On Sunday, August 05, 2012 7:32 PM Aaro Koskinen wrote:

> The alignment mask is calculated incorrectly. Fixing the calculation
> makes strange hangs/lockups disappear during the boot with Amstrad E3
> and 3.6-rc1 kernel.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Again, thanks for spotting and fixing the issue. I've applied it to my fixes branch. 
I'm really sorry for introducing such stupid bugs together with my changes.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
