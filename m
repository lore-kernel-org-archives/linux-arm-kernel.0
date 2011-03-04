From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 4 Mar 2011 11:05:46 +0100
Subject: [PATCH 1/4] OMAP3 and 4 hwmod I2C units only allow 16 bit access
In-Reply-To: <4D70A3E0.6030509@linaro.org>
References: <20110303134744.30648.91218.stgit@otae.warmcat.com>
	<20110303135022.30648.8996.stgit@otae.warmcat.com>
	<4D6FD2F2.8050701@ti.com> <4D6FD63C.6000102@linaro.org>
	<4D6FFCC0.8000007@ti.com> <4D70A3E0.6030509@linaro.org>
Message-ID: <4D70B97A.7000200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/4/2011 9:33 AM, Andy Green wrote:
> On 03/03/2011 08:40 PM, Somebody in the thread at some point said:
>
> Hi -
>
>>>> BTW, It will be good if you could update the omap_hwmod_2430_data.c file
>>>> as well.
>>>
>>> I left it because I can't test it, but I'll happily do it additionally
>>> if you can test it on some OMAP2 hardware.
>>
>> Don't hesitate to do it, and clearly add in the cover-letter that it was
>> tested on 3430 and 4430 only.
>> Someone from TI should be able to test it on 2430.
>
> Alright I will extend the patch series to cover 2430 for this and note
> it is untested.

Cool, thanks for that.
Benoit
