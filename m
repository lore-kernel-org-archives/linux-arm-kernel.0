From: rnayak@ti.com (Rajendra Nayak)
Date: Sat, 25 Feb 2012 10:00:19 +0530
Subject: [PATCH 4/6] ARM: OMAP3: Mark only those mmc devices which use
 gpio_cd, as deferred
In-Reply-To: <20120224222136.GB18901@atomide.com>
References: <1330077537-19618-1-git-send-email-rnayak@ti.com>
 <1330077537-19618-5-git-send-email-rnayak@ti.com>
 <20120224222136.GB18901@atomide.com>
Message-ID: <4F4863DB.9090702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 25 February 2012 03:51 AM, Tony Lindgren wrote:
> * Rajendra Nayak<rnayak@ti.com>  [120224 01:27]:
>> mmc devices which actually do not depend on twl4030-gpio for
>> gpio_cd should not be maked as deferred.
>>
>> Also on overo, since none of the mmc devices need to be deferred,
>> get rid of omap_hsmmc_late_init() altogether.
>>
>> Reported-by: Igor Grinberg<grinberg@compulab.co.il>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
> Thanks, I'll fold this into the original patch with your SOB
> so we avoid the extra churn.

okay, thanks.

>
> Regards,
>
> Tony
