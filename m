From: lenb@kernel.org (Len Brown)
Date: Sat, 02 Jun 2012 01:50:50 -0400
Subject: [linux-pm] [PATCH 0/2] bug fixes for coupled cpuidle
In-Reply-To: <1337364324-12171-1-git-send-email-ccross@android.com>
References: <1337364324-12171-1-git-send-email-ccross@android.com>
Message-ID: <4FC9A9BA.1020904@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2012 02:05 PM, Colin Cross wrote:

> The last modifications made to the coupled cpuidle patches introduced
> two bugs that I missed during testing.  The online count was never
> initialized, causing coupled idle to always wait and never enter the
> ready loop.  That hid the second bug, the ready count could never be
> decremented after exiting idle.
> 
> Len, these two patches could be squashed into patch 3 of the original
> set.  If you do squash them, you could also add Rafael's tags to the
> set (Reviewed-by on 1 and 2, acked-by on 3).


squash & tags update done.

> Or I can reupload the
> whole stack as v5 if you prefer.


no need.

thanks,
-Len Brown, Intel Open Source Technology Center
