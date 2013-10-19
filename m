From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 19 Oct 2013 17:17:18 +0000 (UTC)
Subject: [PATCH 03/11] ARM: OMAP3: McBSP: do not access CM register
 directly
In-Reply-To: <1381508141-15244-4-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
 <1381508141-15244-4-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1310191717050.11676@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> McBSP driver require special hacks to enable/disable the autoidle feature
> for its interface clock for the proper function of the sidetone hardware.
> Currently the driver just writes CM registers directly, which should be
> avoided. Thus, changed the driver to use the new deny/allow_autoidle
> clock API calls.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks, queued.


- Paul
