From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 19 Oct 2013 17:12:38 +0000 (UTC)
Subject: [PATCH 01/11] ARM: OMAP2: CM/PM: remove direct register accesses
 outside CM code
In-Reply-To: <1381508141-15244-2-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
 <1381508141-15244-2-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1310191711130.11676@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> Users of the CM funtionality should not access the CM registers directly
> by themselves. Thus, added new CM driver APIs for the OMAP2 specific
> functionalities which support the existing direct register accesses, and
> changed the platform code to use these. This is done in preparation
> for moving the CM code into its own individual driver.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Thanks, queued.  Not thrilled about returning register bitfields directly 
from these CM functions, but it's incrementally better than what's there.


- Paul
