From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 2 Jun 2015 18:37:23 +0000 (UTC)
Subject: [PATCH 1/2] ARM: OMAP: AM43xx hwmod: Add data for am43xx emif
 hwmod
In-Reply-To: <1430933133-33412-2-git-send-email-d-gerlach@ti.com>
References: <1430933133-33412-1-git-send-email-d-gerlach@ti.com>
 <1430933133-33412-2-git-send-email-d-gerlach@ti.com>
Message-ID: <alpine.DEB.2.02.1506021837080.14902@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 May 2015, Dave Gerlach wrote:

> Without a hwmod for am43xx emif use counting for emif clockdomain does
> not happen correctly so it may be shut off by pm code unintentionally.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Thanks, sent upstream for v4.2.


- Paul
