From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 19 Oct 2013 17:18:03 +0000 (UTC)
Subject: [PATCH 08/11] ARM: OMAP3: control: add API for setting IVA
 bootmode
In-Reply-To: <1381508141-15244-9-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
 <1381508141-15244-9-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1310191717540.11676@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> OMAP3 PM core requires IVA2 bootmode to be set to idle during init. Currently,
> a direct register write is used for this. Add a new ctrl API for this purpose
> instead.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Thanks, queued.


- Paul
