From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 15 Nov 2011 11:00:21 +0100
Subject: [PATCH] merge i.MX5 into mach-imx
In-Reply-To: <20111114015311.GA10217@S2100-06.ap.freescale.net>
References: <1320915966-8063-1-git-send-email-s.hauer@pengutronix.de>
 <20111114015311.GA10217@S2100-06.ap.freescale.net>
Message-ID: <4EC23835.4010504@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.11.2011 02:53, Shawn Guo wrote:
> On Thu, Nov 10, 2011 at 10:06:03AM +0100, Sascha Hauer wrote:
>> Hi,
>>
>> The following series merges i.MX5 support into mach-imx and makes it
>> possible to compile i.MX5 together with i.MX3/6. I originally wanted
>> to wait until the next merge window with this, but I think we can
>> avoid a lot of merging trouble when we just merge it during this
>> -rc cycle. What do you think?
>>
> Using your mx5-merge branch, on imx6q, imx51 and imx53:
> 
> Tested-by: Shawn Guo <shawn.guo@linaro.org>

On imx6q (with Shawn's CONFIG_MMC_BLOCK change):

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks

Dirk
