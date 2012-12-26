From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 26 Dec 2012 20:49:26 +0000 (UTC)
Subject: [PATCH 09/12] ARM: OMAP2+: powerdomain: skip register reads for
 powerdomains known to be on
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ECA6CF8@DBDE01.ent.ti.com>
References: <20121209200108.3196.12452.stgit@dusk.lan>
 <20121209200327.3196.27686.stgit@dusk.lan>
 <B5906170F1614E41A8A28DE3B8D121433ECA6CF8@DBDE01.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1212262048470.2706@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Dec 2012, Bedia, Vaibhav wrote:

> In case of AM33xx, this flag should be set for PER and WKUP pwrdms also.
> EMIF, L3, L4 etc come under PER so this domain can't transition on an active
> system. PRCM and Control module come under WKUP, so the WKUP should the kernel
> should attempt to transition WKUP domain also.

Thanks - the patch has been updated to reflect this.

- Paul
