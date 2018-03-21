From: daniel@fooishbar.org (Daniel Stone)
Date: Wed, 21 Mar 2018 16:47:01 +0000
Subject: [PATCH 08/10] drm/fourcc: Add definitions for Allwinner vendor
 and MB32 tiled format
In-Reply-To: <20180321152904.22411-9-paul.kocialkowski@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-9-paul.kocialkowski@bootlin.com>
Message-ID: <CAPj87rPNgga_pspx_0kTiP4itWUOL3O++2ZCiTUFfNBDGzkd0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 21 March 2018 at 15:29, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> +/*
> + * Allwinner "MB32" tiled format
> + *
> + * This is the primary layout coming out of the VPU, where pixels are tiled
> + * 32x32.
> + */

Can you please be a bit more specific here, following the other
examples? In particular, it should list whether the tile order is row-
or column-major.

Cheers,
Daniel
