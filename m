From: marex@denx.de (Marek Vasut)
Date: Tue, 28 May 2013 20:29:55 +0200
Subject: [PATCH 1/3] ARM: dts: imx28-evk: Enable touchscreen support
In-Reply-To: <20130528062711.GB19608@S2101-09.ap.freescale.net>
References: <1360337803-19858-1-git-send-email-festevam@gmail.com>
 <201305280656.27472.marex@denx.de>
 <20130528062711.GB19608@S2101-09.ap.freescale.net>
Message-ID: <201305282029.55905.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Tue, May 28, 2013 at 06:56:27AM +0200, Marek Vasut wrote:
> > What is the problem you observe?
> 
> The audio playback gives silent output.

You mean like nothing? Zilch? Not even a loud pop on the start/stop of playback?

I have no issues with audio + touchscreen on m28evk since like 3.7 or so (even 
before I pushed the driver mainline), so this is weird. Do you have your 
speakers connected to LineOut or Speaker output from the SGTL5000 ? In case of 
LineOut, is your on-board amplifier on ?

Best regards,
Marek Vasut
