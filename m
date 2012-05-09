From: sameo@linux.intel.com (Samuel Ortiz)
Date: Wed, 9 May 2012 18:03:29 +0200
Subject: [PATCH 3/3] twl4030: enable wakeup on twl4030 IRQ.
In-Reply-To: <20120425030524.7832.66013.stgit@notabene.brown>
References: <20120425025637.7832.14013.stgit@notabene.brown>
 <20120425030524.7832.66013.stgit@notabene.brown>
Message-ID: <20120509160329.GP1794@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Wed, Apr 25, 2012 at 01:05:24PM +1000, NeilBrown wrote:
> Most of the interrupts that come through this line should trigger
> wakeups:
>   power button
>   RTC alarm
>   power available
>   usb plug/unplug
> 
> so mark the interrupt as a wakeup interrupt.
> This is particularly important for when the interrupt arrives during
> the late suspend phase.  Without this setting it will be ignored.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> 
>  drivers/mfd/twl4030-irq.c |    1 +
>  1 file changed, 1 insertion(+)
Patch applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
