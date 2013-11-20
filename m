From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Nov 2013 14:18:12 +0800
Subject: [PATCH 1/2] ARM: dts: i.MX51: Move usbphy0 node from AIPS1
In-Reply-To: <1384861647-28567-1-git-send-email-shc_work@mail.ru>
References: <1384861647-28567-1-git-send-email-shc_work@mail.ru>
Message-ID: <20131120061810.GC19680@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 03:47:26PM +0400, Alexander Shiyan wrote:
> usbphy0 is not a part of AIPS1, so move this node under root.
> Additionally this patch removes useless "status" property.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied both, thanks.
