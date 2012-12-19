From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Dec 2012 16:57:24 +0000 (UTC)
Subject: [PATCH] ARM: OMAP4: PRM: fix RSTTIME and RSTST offsets
In-Reply-To: <1355911588-21977-3-git-send-email-ivan.khoronzhuk@ti.com>
References: <1355911588-21977-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1355911588-21977-3-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <alpine.DEB.2.00.1212191657170.16873@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Dec 2012, Ivan Khoronzhuk wrote:

> From: Nishanth Menon <nm@ti.com>
> 
> RSTTIME is offset 0x8 and RSTST is offset 0x04 for OMAP4430 and
> OMAP4460.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> [ivan.khoronzhuk at ti.com: ported from k3.4]
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

Thanks guys, queued for v3.8-rc fixes.

- Paul
