From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 19 May 2014 19:37:29 +0300
Subject: [PATCH v3 02/13] ARM: edma: Take the number of tc from
 edma_soc_info (pdata)
In-Reply-To: <5379E5E6.9080500@ti.com>
References: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com>
 <1400242640-9902-3-git-send-email-peter.ujfalusi@ti.com>
 <5379E5E6.9080500@ti.com>
Message-ID: <537A3349.3030404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2014 02:07 PM, Sekhar Nori wrote:
> To which baseline do the patches apply? These lines are not present at
> least in v3.15-rc5. I am applying the patch without this hunk.

It is generate on top of linux-next-20140515.
next picked up several patches since 3.15-rc and I also have my other patch in
my working branch under this series:
ARM: edma: Clean up and simplify the code around irq request

--
P?ter
