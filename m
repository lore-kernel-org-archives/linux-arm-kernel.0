From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Apr 2013 10:20:03 +0800
Subject: [PATCH v2 0/3] Get rid of big array from imx pinctrl driver
In-Reply-To: <CAOMZO5AVra7Hrf5rJvr5UWP=B2m18Dyw2tb4jC8JwxFVNr5i3Q@mail.gmail.com>
References: <1361533888-18073-1-git-send-email-shawn.guo@linaro.org>
 <CAOMZO5D1+baoM0vMdPW9bAd4DX8C82BF9H87igFNo78+8D_N3Q@mail.gmail.com>
 <20130407071028.GD11898@S2101-09.ap.freescale.net>
 <CAOMZO5BCQiRMp8KG-beDkDyX8VSq7Arzs+vJ+xU+SYXRPjgDzA@mail.gmail.com>
 <CAOMZO5AVra7Hrf5rJvr5UWP=B2m18Dyw2tb4jC8JwxFVNr5i3Q@mail.gmail.com>
Message-ID: <20130408022001.GF11898@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 07, 2013 at 06:52:11PM -0300, Fabio Estevam wrote:
> On Sun, Apr 7, 2013 at 4:56 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Sun, Apr 7, 2013 at 4:10 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> >
> >> I just rebuilt imx/dt branch with the problem fixed and also had the
> >> branch based on Stephen Warren's for-3.10/dtc-cpp-chroot-std-headers
> >> branch so avoid all those dts files renaming.
> >
> > Does imx6dl boot for you in your updated imx/dt branch?
> >
> > It used to boot previously, but after the update it no longer boots.
> 
> Your updated branch missed:
> 
> [PATCH 3/6] ARM: imx: add initial imx6dl support

It's never been on imx/dt branch but imx/soc.  So for-next can be used
to boot imx6dl.

Shawn
