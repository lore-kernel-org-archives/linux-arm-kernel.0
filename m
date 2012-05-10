From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 17:45:36 +0800
Subject: [PATCH V2 08/11] ARM: dts: imx6q-sabrelite: add sound device
 imx6q-sabrelite-sgtl5000
In-Reply-To: <20120510094113.GG17875@S2101-09.ap.freescale.net>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-9-git-send-email-richard.zhao@freescale.com>
 <20120510064816.GC17875@S2101-09.ap.freescale.net>
 <20120510093444.GI2982@b20223-02.ap.freescale.net>
 <20120510094113.GG17875@S2101-09.ap.freescale.net>
Message-ID: <20120510094534.GH17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 05:41:15PM +0800, Shawn Guo wrote:
> On Thu, May 10, 2012 at 05:34:45PM +0800, Richard Zhao wrote:
> > > "Mic Bias" is a SUPPLY for both "MIC_IN" and "Mic Jack", so it should
> > > look like:
> > > 
> > >                        "Mic Jack", "Mic Bias",
> > >                        "MIC_IN", "Mic Bias",
> > Not really. The circuit:
> > MIC_IN <-- capacitor <--> Mic Jack
> >                       /
> >             Mic Bias /
> > 
> The "Mic Bias" here is really a SGTL5000 internal supply.
> 
Look SGTL5000 datasheet for "MIC_BIAS".

-- 
Regards,
Shawn
