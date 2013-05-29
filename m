From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 29 May 2013 10:00:23 +0800
Subject: [PATCH 1/3] ARM: dts: imx28-evk: Enable touchscreen support
In-Reply-To: <201305282029.55905.marex@denx.de>
References: <1360337803-19858-1-git-send-email-festevam@gmail.com>
 <201305280656.27472.marex@denx.de>
 <20130528062711.GB19608@S2101-09.ap.freescale.net>
 <201305282029.55905.marex@denx.de>
Message-ID: <20130529020021.GA370@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 08:29:55PM +0200, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > On Tue, May 28, 2013 at 06:56:27AM +0200, Marek Vasut wrote:
> > > What is the problem you observe?
> > 
> > The audio playback gives silent output.
> 
> You mean like nothing? Zilch? Not even a loud pop on the start/stop of playback?
> 
Nothing.

> I have no issues with audio + touchscreen on m28evk since like 3.7 or so (even 
> before I pushed the driver mainline), so this is weird. Do you have your 
> speakers connected to LineOut or Speaker output from the SGTL5000 ? In case of 
> LineOut, is your on-board amplifier on ?
> 
Only headphone.

Shawn
