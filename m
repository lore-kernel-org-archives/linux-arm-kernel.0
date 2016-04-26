From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 26 Apr 2016 13:00:04 +0100
Subject: [PATCH 01/18] dmaengine: st_fdma: Add STMicroelectronics FDMA DT
 binding documentation
In-Reply-To: <3920014.LnOL9gjB2a@wuerfel>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-2-git-send-email-peter.griffin@linaro.org>
 <3920014.LnOL9gjB2a@wuerfel>
Message-ID: <20160426120004.GC5457@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, 21 Apr 2016, Arnd Bergmann wrote:

> On Thursday 21 April 2016 12:04:18 Peter Griffin wrote:
> > +- clocks       : Must contain an entry for each name in clock-names
> > +- clock-names  : Must contain "fdma_slim, fdma_hi, fdma_low, fdma_ic" entries
> > +See: Documentation/devicetree/bindings/clock/clock-bindings.txt
> 
> The fdma_ prefix for the clock names is redundant, just make these
> "slim", "hi", "low", and "ic".

Ok will fix in v4.

Peter.
