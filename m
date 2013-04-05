From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 5 Apr 2013 08:35:47 -0700
Subject: [PATCH] Revert "drivers/rtc/rtc-at91rm9200.c: use a variable for
 storing IMR"
In-Reply-To: <515EDC4B.3010508@atmel.com>
References: <20130403095150.GC27600@localhost>
 <1364982862-19759-1-git-send-email-jhovold@gmail.com>
 <515C0208.2000605@atmel.com> <515EDC4B.3010508@atmel.com>
Message-ID: <20130405153547.GA515@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 04:14:35PM +0200, Nicolas Ferre wrote:
> On 04/03/2013 12:18 PM, Nicolas Ferre :
> > On 04/03/2013 11:54 AM, Johan Hovold :
> >> This reverts commit 0ef1594c017521ea89278e80fe3f80dafb17abde.
> >>
> >> This patch introduced a few races which cannot be easily fixed with a
> >> small follow-up patch. Furthermore, the SoC with the broken hardware
> >> register, which this patch intended to add support for, can only be used
> >> with device trees, which this driver currently does not support.
> >>
> >> Cc: stable <stable@vger.kernel.org>
> >> Signed-off-by: Johan Hovold <jhovold@gmail.com>
> > 
> > Fair enough, after fighting to find a solution that can makes us move
> > forward... your strong arguments convinced me.
> > 
> > So, Andrew, please can you take this "revert" patch for 3.9-rc ?
> > And sorry for the noise.
> > 
> > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > 
> > (Andrew, I figured out that you are not in copy of the original email:
> > do I need to send it back to you or can you pick it up in patchwork?
> > https://patchwork.kernel.org/patch/2385921/
> > )
> 
> Andrew, ping?

Andrew is on vacation for a few weeks, sorry.

Perhaps you should send this yourself?

greg k-h
