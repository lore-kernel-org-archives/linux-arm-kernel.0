From: sameo@linux.intel.com (Samuel Ortiz)
Date: Sun, 3 Feb 2013 23:32:29 +0100
Subject: [PATCH] mfd: vexpress: Add pseudo-GPIO based LEDs
In-Reply-To: <1359541996-18127-1-git-send-email-pawel.moll@arm.com>
References: <1359541996-18127-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20130203223229.GA8476@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On Wed, Jan 30, 2013 at 10:33:16AM +0000, Pawel Moll wrote:
> The LEDs on the Versatile Express motherboard are controlled
> through simple memory-mapped register. This patch extends
> the pseudo-GPIO controller definition for these lines and
> creates generic "leds-gpio" device using them
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
> 
> Hello Samuel,
> 
> Would you be so kind to take this patch in for 3.9? Or would
> you prefer to get it in through arm-soc tree?
> 
> Thanks!
> 
> Pawel
> 
>  drivers/mfd/vexpress-sysreg.c |   73 +++++++++++++++++++++++++++++++----------
>  include/linux/vexpress.h      |    8 +++++
>  2 files changed, 63 insertions(+), 18 deletions(-)
Applied to my for-next branch, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
