From: vkoul@kernel.org (Vinod)
Date: Thu, 28 Jun 2018 11:24:28 +0530
Subject: [PATCH] dmaengine: pl330: report BURST residue granularity
In-Reply-To: <20180619132105eucas1p2d65cbd799e60a8ab1849c4ae716275c4~5klprrrtK1347113471eucas1p2M@eucas1p2.samsung.com>
References: <CGME20180619132105eucas1p2d65cbd799e60a8ab1849c4ae716275c4@eucas1p2.samsung.com>
 <20180619132105eucas1p2d65cbd799e60a8ab1849c4ae716275c4~5klprrrtK1347113471eucas1p2M@eucas1p2.samsung.com>
Message-ID: <20180628055428.GM22377@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-06-18, 15:20, Marek Szyprowski wrote:
> The reported residue is already calculated in BURST unit granularity, so
> advertise this capability properly to other devices in the system.

Applied, thanks

-- 
~Vinod
