From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Aug 2012 16:58:08 +0100
Subject: [PATCH 3/5] ASoC: Davinci: pcm: Add device tree bindings
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA67DA1@DBDE01.ent.ti.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-4-git-send-email-gururaja.hebbar@ti.com>
 <20120817223122.GA21445@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EA67DA1@DBDE01.ent.ti.com>
Message-ID: <20120822155808.GP7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 01:50:09PM +0000, Hebbar, Gururaja wrote:

> From your for-3.7 branch, I could only find such implementation in Tegra
> Platform. 
> Most Freescale platforms implements this through a device/driver method.
> Exception being sound/soc/mxs/mxs-pcm.c

> So should I follow tegra implementation?

Tegra and mxs should be good examples, yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/bfc3c9ea/attachment.sig>
