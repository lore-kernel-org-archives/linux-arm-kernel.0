From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Tue, 17 Jan 2017 19:39:41 +0530
Subject: [PATCH 1/2] arm64: dts: exynos: Add USB 3.0 controller node for
 Exynos7
In-Reply-To: <3a607d18-acf9-37f5-a6d4-7f8fe538d27f@osg.samsung.com>
References: <1484649143-19423-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170117102939epcas5p1aa25d6d8d080c086fb237e645bedbd17@epcas5p1.samsung.com>
 <1484649143-19423-2-git-send-email-pankaj.dubey@samsung.com>
 <3a607d18-acf9-37f5-a6d4-7f8fe538d27f@osg.samsung.com>
Message-ID: <23067cbb-08de-abd9-3530-246c81ba5931@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Tuesday 17 January 2017 07:07 PM, Javier Martinez Canillas wrote:
> Hello Pankaj,
> 
> On 01/17/2017 07:32 AM, Pankaj Dubey wrote:
>> Add USB 3.0 DRD controller device node, with its clock
>> and phy information to enable the same on Exynos7.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Signed-off-by: Vivek Gautam <gautamvivek1987@gmail.com>
> 
> The S-o-B order isn't correct. You are the one posting the patch so
> yours should be the last one.
> 
> Also, wasn't this patch originally from Vivek? If you didn't change
> that much, I think that he should be listed as the patch author.
> 

Thanks for review.

Just noticed, I missed to take care of this, as original patch could not
be applied on latest tree and I had to do all these changes manually,
will submit soon with Signed-off-by and author change.

Thanks,
Pankaj Dubey

> I don't have an Exynos7 manual to verify but the patch looks good.
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> Best regards,
> 
