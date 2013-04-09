From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Apr 2013 19:57:46 +0800
Subject: [PATCH v2 0/3] Get rid of big array from imx pinctrl driver
In-Reply-To: <CACRpkdZL084APsYD_g44Yxx5fWC-8e6bvS6xKpr_2YrXDMhwZQ@mail.gmail.com>
References: <1361533888-18073-1-git-send-email-shawn.guo@linaro.org>
 <CAOMZO5D1+baoM0vMdPW9bAd4DX8C82BF9H87igFNo78+8D_N3Q@mail.gmail.com>
 <20130407071028.GD11898@S2101-09.ap.freescale.net>
 <CAOMZO5Bxfj9ZGrVOcNirsVHFLWaHWBdkFpKSiVQ9iS4paT0Y6g@mail.gmail.com>
 <20130407142610.GE11898@S2101-09.ap.freescale.net>
 <CAOMZO5A-nwmb=6G-D_2LBNsPYH4C8Z686BjS3vd3WhzvnDFfqw@mail.gmail.com>
 <20130408060857.GA5047@S2101-09.ap.freescale.net>
 <CACRpkdZL084APsYD_g44Yxx5fWC-8e6bvS6xKpr_2YrXDMhwZQ@mail.gmail.com>
Message-ID: <20130409115744.GF5044@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 10:36:59AM +0200, Linus Walleij wrote:
> On Mon, Apr 8, 2013 at 8:09 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > --8<-----
> >
> > diff --git a/drivers/pinctrl/pinctrl-imx6q.c b/drivers/pinctrl/pinctrl-imx6q.c
> > index f00f532..76dd9c4 100644
> > --- a/drivers/pinctrl/pinctrl-imx6q.c
> > +++ b/drivers/pinctrl/pinctrl-imx6q.c
> 
> Acked-by. I trust you to fix up and merge the outcome of this Shawn...

Thanks, Linus.  Thanks to Fabio too for noticing the bugs.

Shawn
