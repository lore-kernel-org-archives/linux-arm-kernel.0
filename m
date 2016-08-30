From: mindentropy@gmail.com (mind entropy)
Date: Tue, 30 Aug 2016 23:55:18 +0530
Subject: disable_anatop_clocks switches off the pll2_pfd2_396m used for lpddr2
 causing a hang
Message-ID: <CAM2a4uxxJbAAEaW6zb7YZPi-j3Rx9mmJraC5UJ3c1jg67TvxQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

  The patch as present in the
https://marc.info/?l=linux-arm-kernel&m=140198575118026&q=raw disables
the pll2_pfd2_396m in the i.mx6 dual lite which is being used by the
lpddr2. I have a board which I run lpddr2 at 200 MHz which uses the
pll2_pfd2 (/2). How do I make the parent of IMX6QDL_CLK_PERPIH_PRE,
IMX6QDL_CLK_PLL2_PFD2_396M ? Should it be in the dts file or in the
code?

Thanks,
Gautam.
