From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 19 Oct 2013 17:17:36 +0000 (UTC)
Subject: [PATCH 04/11] ARM: OMAP3: CM/control: move CM scratchpad save
 to CM driver
In-Reply-To: <1381508141-15244-5-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
 <1381508141-15244-5-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1310191717250.11676@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> OMAP3 PM code for off-mode currently saves the scratchpad contents for CM
> registers within OMAP control module driver. However, as we are separating
> CM code into its own driver, this must be moved also. This patch adds a
> new API for saving the CM scratchpad contents and uses this from the high
> level scratchpad save function.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Thanks, queued.


- Paul
