From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 5 Apr 2012 09:08:32 +0800
Subject: [PATCH v8 4/4] ARM: mxs/mx28evk: add GPMI-NAND device
In-Reply-To: <CAOMZO5D_ACi73J0QfXoJmvyw6fBMrQfyoKLkK2P+-kMm5EzaDQ@mail.gmail.com>
References: <1314169643-23425-1-git-send-email-b32955@freescale.com>
 <1314169643-23425-5-git-send-email-b32955@freescale.com>
 <CAOMZO5D_ACi73J0QfXoJmvyw6fBMrQfyoKLkK2P+-kMm5EzaDQ@mail.gmail.com>
Message-ID: <20120405010829.GG7264@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 09:44:52PM -0300, Fabio Estevam wrote:
> Hi Shawn,
> 
> On Wed, Aug 24, 2011 at 4:07 AM, Huang Shijie <b32955@freescale.com> wrote:
> > add GPMI-NAND device for mx28evk board.
> >
> > Signed-off-by: Huang Shijie <b32955@freescale.com>
> 
> Can this one be applied now?
> 
No.

1) The pin confliction between gpmi and lcdif remains.
2) I intend to freeze the board file updates, as we are on the way to
   device tree.

So instead of patching board file, please contribute to device tree
conversion.

-- 
Regards,
Shawn
