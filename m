From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 17 Mar 2012 08:07:59 +0800
Subject: [alsa-devel] [PATCH v5 8/8] ASoC: fsl: add imx-sgtl5000 machine
 driver
In-Reply-To: <CA+7tXih-omxaDq6dSKBeOaZ7YRWDVSQnMY=eJZ0-YumOBG=oCA@mail.gmail.com>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
 <1331888204-27058-9-git-send-email-shawn.guo@linaro.org>
 <CA+7tXihmfBQCgvuY0rx5v4w-bcwYK+7kP9v29w36N-Rc9KSQ+A@mail.gmail.com>
 <20120316111814.GA7860@S2101-09.ap.freescale.net>
 <20120316192110.GH3158@opensource.wolfsonmicro.com>
 <CA+7tXih-omxaDq6dSKBeOaZ7YRWDVSQnMY=eJZ0-YumOBG=oCA@mail.gmail.com>
Message-ID: <20120317000757.GB7860@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 05:28:54PM -0400, Trent Piepho wrote:
> On Fri, Mar 16, 2012 at 3:21 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Fri, Mar 16, 2012 at 07:18:18PM +0800, Shawn Guo wrote:
> >
> >> Maybe having "fsl,imx-audio-xxx" for machine drivers backed by SSI,
> >> and "fsl,imx-esai-audio-xxx" for the ones backed by ESAI?
> 
> It seems non-orthogonal to me that ESAI has esai in the name but SSI
> does not have ssi.
> 
SSI comes first and so takes the "default and shorter" name :)

-- 
Regards,
Shawn
