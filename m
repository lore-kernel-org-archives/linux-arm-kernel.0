From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 21 Aug 2017 14:39:56 +0530
Subject: [PATCH v2 2/3] i2c: davinci: Add PM Runtime Support
In-Reply-To: <20170817162427.izbfsa7xatjxb2aw@ninjato>
References: <20170816221715.15027-1-fcooper@ti.com>
 <20170816221715.15027-3-fcooper@ti.com>
 <20170817162427.izbfsa7xatjxb2aw@ninjato>
Message-ID: <3996b44e-68cd-0a19-c685-64f6345cdf88@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Thursday 17 August 2017 09:54 PM, Wolfram Sang wrote:
> On Wed, Aug 16, 2017 at 05:17:14PM -0500, Franklin S Cooper Jr wrote:
>> 66AK2G has I2C instances that are not apart of the ALWAYS_ON power domain
>> like other Keystone 2 SoCs and OMAPL138. Therefore, pm_runtime
>> is required to insure the power domain used by the specific I2C instance is
>> properly turned on along with its functional clock.
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> 
> I'd need a review from the driver maintainers here. Which are Sekhar
> Nori and Kevin Hilman(?) according to MAINTAINERS. Is that still
> correct?

I just finished the review (sent the comments). Thanks for the reminder!

Also, tested the patches using i2cdetect and suspend/resume on OMAP-L138
LCDK board.

Regards,
Sekhar
