From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Nov 2015 22:53:29 +0800
Subject: [PATCH v2] ARM: imx_v6_v7_defconfig: Select HDMI audio support
In-Reply-To: <CAOMZO5AwYny8OZCohCP0Zcc+pxyLawwJ=tUJrqsu8ORHSG6u-A@mail.gmail.com>
References: <1447687238-11559-1-git-send-email-fabio.estevam@freescale.com>
 <20151124062004.GJ11999@tiger>
 <CAOMZO5AwYny8OZCohCP0Zcc+pxyLawwJ=tUJrqsu8ORHSG6u-A@mail.gmail.com>
Message-ID: <20151124145329.GY11999@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 07:25:13AM -0200, Fabio Estevam wrote:
> On Tue, Nov 24, 2015 at 4:20 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Mon, Nov 16, 2015 at 01:20:38PM -0200, Fabio Estevam wrote:
> >> Select CONFIG_DRM_DW_HDMI_AHB_AUDIO so that we have HDMI audio
> >> supported by default.
> >>
> >> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> >> ---
> >> Changes since v1:
> >> - Select the driver as module instead of built-in
> >
> > I've applied a previous version.  Should I replace it with this one?
> 
> Yes, please.

Done.
