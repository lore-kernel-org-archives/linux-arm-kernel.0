From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 6 Aug 2012 05:55:08 +0200
Subject: [PATCH] ARM: mxs_defconfig: Enable USB host
In-Reply-To: <CAOMZO5CevtbEdch5v9jt5Gyis8o6C1-Vrm1p=289Gpx4zd_wxQ@mail.gmail.com>
References: <1344186258-30841-1-git-send-email-festevam@gmail.com>
 <20120806025806.GA22302@S2101-09.ap.freescale.net>
 <CAOMZO5CevtbEdch5v9jt5Gyis8o6C1-Vrm1p=289Gpx4zd_wxQ@mail.gmail.com>
Message-ID: <201208060555.08447.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> On Sun, Aug 5, 2012 at 11:58 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > I guess you did not run savedefconfig.  We do not need all those
> > options explicitly added there.
> 
> No, I have not run savedefconfig. What is the correct way to use it?

make mxs_config
<edit>
make savedefconfig

I'd guess ...

> Regards,
> 
> Fabio Estevam

Best regards,
Marek Vasut
