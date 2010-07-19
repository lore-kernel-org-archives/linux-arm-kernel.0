From: michael.williamson@criticallink.com (Michael Williamson)
Date: Mon, 19 Jul 2010 16:24:41 -0400
Subject: [PATCH v2] davinci: Add MityDSP-L138/MityARM-1808 SOM support
In-Reply-To: <20100719193604.GA22547@n2100.arm.linux.org.uk>
References: <4C44515A.4030003@criticallink.com>
	<20100719193604.GA22547@n2100.arm.linux.org.uk>
Message-ID: <4C44B489.8080609@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On 7/19/2010 3:36 PM, Russell King - ARM Linux wrote:

> On Mon, Jul 19, 2010 at 09:21:30AM -0400, Michael Williamson wrote:
>>  arch/arm/configs/mityomapl138_defconfig            | 1764 ++++++++++++++++++++
>
> Please don't include full defconfigs; we've recently reduced the size of
> those merged because they're getting OTT.  Please combine your defconfig
> with another existing defconfig where possible.
>
> If not, Uwe has a script which can be run to reduce the size of the
> defconfig.  However, I'd personally prefer to see a reduction in the
> number of defconfigs we have now.



OK. I think I can roll this in with the da8xx_omapl_defconfig and scrap the one
submitted.

Thanks for the feedback.

-Mike
