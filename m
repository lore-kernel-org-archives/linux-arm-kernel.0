From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 21 May 2012 12:14:49 +0530
Subject: [PATCH 0/2] bug fixes for coupled cpuidle
In-Reply-To: <1337364324-12171-1-git-send-email-ccross@android.com>
References: <1337364324-12171-1-git-send-email-ccross@android.com>
Message-ID: <4FB9E461.9060405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 May 2012 11:35 PM, Colin Cross wrote:
> The last modifications made to the coupled cpuidle patches introduced
> two bugs that I missed during testing.  The online count was never
> initialized, causing coupled idle to always wait and never enter the
> ready loop.  That hid the second bug, the ready count could never be
> decremented after exiting idle.
> 
> Len, these two patches could be squashed into patch 3 of the original
> set.  If you do squash them, you could also add Rafael's tags to the
> set (Reviewed-by on 1 and 2, acked-by on 3).  Or I can reupload the
> whole stack as v5 if you prefer.

I confirm that these two fixes are needed to get couple idle
v4 series working.

Regards
Santosh
