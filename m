From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 4 Apr 2012 22:19:25 -0300
Subject: [PATCH v8 4/4] ARM: mxs/mx28evk: add GPMI-NAND device
In-Reply-To: <20120405010829.GG7264@S2101-09.ap.freescale.net>
References: <1314169643-23425-1-git-send-email-b32955@freescale.com>
 <1314169643-23425-5-git-send-email-b32955@freescale.com>
 <CAOMZO5D_ACi73J0QfXoJmvyw6fBMrQfyoKLkK2P+-kMm5EzaDQ@mail.gmail.com>
 <20120405010829.GG7264@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5ACk06aFWmmH0ZXCf6XoLaShwUaoAW0jHKmDTsJ0v027A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 4, 2012 at 10:08 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> No.
>
> 1) The pin confliction between gpmi and lcdif remains.
> 2) I intend to freeze the board file updates, as we are on the way to
> ? device tree.
>
> So instead of patching board file, please contribute to device tree
> conversion.

I don't see mx28 dts support in mainline yet.

Does it mean my spi patches will not be accepted as well?
