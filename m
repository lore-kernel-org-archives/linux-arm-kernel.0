From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 07 Sep 2012 16:35:21 +0300
Subject: [PATCH v3 08/14] Input: twl4030-vibra: Support for DT booted
 kernel
In-Reply-To: <20120906161933.GA18562@core.coreip.homeip.net>
References: <1346933541-21547-1-git-send-email-peter.ujfalusi@ti.com>
 <1346933541-21547-9-git-send-email-peter.ujfalusi@ti.com>
 <20120906161933.GA18562@core.coreip.homeip.net>
Message-ID: <5049F819.1080101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

On 09/06/2012 07:19 PM, Dmitry Torokhov wrote:
> In patch 6 you added a stub for of_find_node_by_name(), so do you really
> need this #ifdef?

True. I'll resend the series since I left the #ifdef also in other patch.

> Otherwise it looks good.
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thank you,
P?ter
