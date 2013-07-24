From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 25 Jul 2013 00:03:29 +0530
Subject: [PATCH] dma: edma: add device_slave_caps() support
In-Reply-To: <51F0231C.7000401@ti.com>
References: <1374597804-3961-1-git-send-email-joelf@ti.com>
 <51EF8A52.90902@metafoo.de> <51EF8C2B.2030409@ti.com>
 <51EF8F4E.8080806@metafoo.de>
 <FB20353E-4890-4462-A671-3587A3841B4A@ti.com>
 <51EF92F2.3030405@metafoo.de> <51F0231C.7000401@ti.com>
Message-ID: <20130724183329.GH18642@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 01:55:24PM -0500, Joel Fernandes wrote:
> On 07/24/2013 03:40 AM, Lars-Peter Clausen wrote:
> > On 07/24/2013 10:28 AM, Fernandes, Joel wrote:
> >>>>>> Vinod, or Dan- If this patch looks ok, can you please merge in for
> >>>>>> -rc cycle? This patch is required to fix MMC support on AM33xx. This
> >>>>>> patch is blocking 3 other patches which fix various MMC things. Thanks!
Sorry I was travelling so not realy on top of email for last few days...

Now I am not sure we can send this to -rc.
If it were just this one, we could have pushed but it also depends on a new API
which is sitting in my -next. I am not super comfortable to send that to Linus
for the -rcs. Sure, he would scream at me!

Also another point worth considering is the approach Russell suggested, I havent
gotten a chance to dig deeper but if I understood it correctly then programming
the device_dma_parameters should be the right thing to do. Again I need to look
deeper and esp wrt edma

~Vinod
