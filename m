From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Dec 2012 16:57:11 +0000 (UTC)
Subject: [PATCH] ARM: OMAP4: PRM: Correct reset source map
In-Reply-To: <1355911588-21977-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1355911588-21977-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <alpine.DEB.2.00.1212191656590.16873@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Dec 2012, Ivan Khoronzhuk wrote:

> In the map for reset sources register we use defines intended for
> using with PRM_RSTCTRL register. So fix it.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

Thanks, queued for v3.8-rc fixes.


- Paul
