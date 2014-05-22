From: davem@davemloft.net (David Miller)
Date: Thu, 22 May 2014 15:51:02 -0400 (EDT)
Subject: [PATCH] xilinx: Use time_before_eq()
In-Reply-To: <1400785828-1551-1-git-send-email-manuel.schoelling@gmx.de>
References: <1400785828-1551-1-git-send-email-manuel.schoelling@gmx.de>
Message-ID: <20140522.155102.429779731290445105.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manuel Sch?lling <manuel.schoelling@gmx.de>
Date: Thu, 22 May 2014 21:10:28 +0200

> To be future-proof and for better readability the time comparisons are modified
> to use time_before_eq() instead of plain, error-prone math.
> 
> Signed-off-by: Manuel Sch?lling <manuel.schoelling@gmx.de>

Applied.
