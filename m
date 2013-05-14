From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 14 May 2013 21:47:20 +0800
Subject: [PATCH] pinctrl: enable build of pinctrl-imx6sl driver
In-Reply-To: <CACRpkdaKJ-D2FbwSWNeqZrjDJ33nR3P26Yy_1mkPmX9zLTKrfA@mail.gmail.com>
References: <1368407762-12084-1-git-send-email-shawn.guo@linaro.org>
 <CACRpkdaKJ-D2FbwSWNeqZrjDJ33nR3P26Yy_1mkPmX9zLTKrfA@mail.gmail.com>
Message-ID: <20130514134718.GD16250@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 02:54:50PM +0200, Linus Walleij wrote:
> On Mon, May 13, 2013 at 3:16 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > The pinctrl-imx6sl is in place.  Enable the build of it.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Applied for devel (v3.11) or is this to be considered a fix,
> i.e. is someone compiling mainline kernels for the
> IMX6SL already in v3.10?

IMX6SL platform support is targeting v3.11, so it's fine to take the
patch as a v3.11 material.

Shawn
