From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 14 Apr 2012 08:44:49 -0700
Subject: [PATCH][RESEND] ARM: SAMSUNG: make SAMSUNG_PM_DEBUG select
 DEBUG_LL
In-Reply-To: <201204121411.55054.heiko@sntech.de>
References: <201203202120.45806.heiko@sntech.de>
 <4F6B398A.8040703@samsung.com> <201204121411.55054.heiko@sntech.de>
Message-ID: <4F899B71.1090303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/12 05:11, Heiko St?bner wrote:
> Am Donnerstag, 22. M?rz 2012, 15:39:06 schrieb Kukjin Kim:
>> On 03/20/12 13:20, Heiko St?bner wrote:
>>> From: Maurus Cuelenaere<mcuelenaere@gmail.com>
>>>
>>> When selecting SAMSUNG_PM_DEBUG, it complains about a missing
>>> printascii() function if you do not select DEBUG_LL, so make the former
>>> select the latter.
>>>
>>> Signed-off-by: Maurus Cuelenaere<mcuelenaere@gmail.com>
>>> Acked-by: Heiko Stuebner<heiko@sntech.de>
>>> ---
>>> This was originally sent in september 2010, but seems to have been
>>> forgotten. As this problem has bitten me today, here it is again.
>>
>> Yeah, missed. Looks good to me and will apply.
>
> thanks, but it seems I can't find it in the linux-samsung git currently.
>
> Any news on this?
>
Oops, I didn't push :( thanks for your reminder.

You can see it now :)

Ah one more note will look at your s3c24xx patches in the beginning of 
next week, sorry for late.

Thanks.

Best regards,
Gene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
