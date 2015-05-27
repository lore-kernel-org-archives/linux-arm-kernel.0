From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 27 May 2015 09:57:19 +0200
Subject: [PATCH 0/2] ARM: dts: add Okaya LCD display for Nitrogen and
 Sabrelite
In-Reply-To: <CAAMH-yt_4HE_HWHVvb1QFZLgtGCNdoxB=BwTBHcW2JToeuC_6w@mail.gmail.com>
References: <1432314867-30888-1-git-send-email-gary.bisson@boundarydevices.com>
 <20150527030636.GB16165@dragon>
 <CAAMH-yt_4HE_HWHVvb1QFZLgtGCNdoxB=BwTBHcW2JToeuC_6w@mail.gmail.com>
Message-ID: <1432713439.4884.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gary, Shawn,

Am Mittwoch, den 27.05.2015, 09:38 +0200 schrieb Gary Bisson:
> Philipp, Shawn, All,
> 
> On Wed, May 27, 2015 at 5:06 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Fri, May 22, 2015 at 07:14:25PM +0200, Gary Bisson wrote:
> >> This series adds the Okaya 7" LCD display that is a WVGA (800x480) panel with
> >> a 18-bit parallel interface for both Nitrogen and Sabrelite.
> >>
> >> A U-Boot script to configure the displays based on detection of the
> >> touch controller is available for reference here:
> >> https://github.com/boundarydevices/u-boot-imx6/blob/staging/board/boundary/nitrogen6x/6x_bootscript-mainline.txt
> >>
> >> Gary Bisson (2):
> >>   ARM: dts: imx6qdl-nitrogen6x: add Okaya LCD display
> >>   ARM: dts: imx6qdl-sabrelite: add Okaya LCD display
> >
> > Philipp,
> >
> > Are you okay with these two patches?
> 
> I've actually just ran into Philipp's patch on drm_panel support for
> parallel-display driver.
> https://patchwork.kernel.org/patch/6438311/
> 
> If the above patch is merged soon, maybe mine should be reworked to
> use the panel as well (and add the Okaya timings to the simple panel
> driver).
> 
> Let me know what would be the best.

Yes, please add Okaya LCD support to the simple-panel driver instead.
I'll send a pull request with the panel patch.

regards
Philipp
