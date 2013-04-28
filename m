From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 28 Apr 2013 20:19:47 +0800
Subject: [PATCH] Support fsl-dcp crypto coprocessor
In-Reply-To: <341422577.566569.1366721757554.open-xchange@email.1und1.de>
References: <1366710460-11637-1-git-send-email-cb@sgoc.de>
 <20130423123408.GB1366@pengutronix.de>
 <341422577.566569.1366721757554.open-xchange@email.1und1.de>
Message-ID: <20130428121944.GB15901@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 02:55:57PM +0200, Christoph G. Baumann wrote:
> 
> > IMHO it doesn't make any sense to push this into staging. The Freescale
> > kernel is full of drivers which are not ready for mainline yet.
> 
> Indeed the Freescale kernel is a heap of <censored>.
> 
> 
> > Until now, it was a good strategy to wait until some code is needed,
> > then clean it up, adapt it to the right kernel APIs and push it into
> > non-staging mainline.
> 
> Well, that's what I'm trying to do. I picked a particular driver and
> adapted it to the current mainline.

Then why not put them into drivers/crypto/ rather than
drivers/staging/crypto/?

Shawn

> So if there are concrete proposals or criticism about this patch, please
> tell me. As I stated the code is from Freescale and I won't be offended.
