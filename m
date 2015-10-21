From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 21 Oct 2015 15:25:59 +0200
Subject: [PATCH v2 0/6] Switch to generic syscon regmap based drivers
In-Reply-To: <CANAwSgRR6OQ3e8RCxB2DQHJNx_LvOwE9CnmCk1oGJMBUuKfeCg@mail.gmail.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
 <CAGOxZ50G-ttivhVjbozUisA0HXcFz7bvRUuPR67xR88TTCa_wQ@mail.gmail.com>
 <CAGOxZ51_JPy51htzD_M_=qaPVUexkVhoA2ANLS2-rpK3QDT=8A@mail.gmail.com>
 <1606098.olLAyTIhB3@dell2.five-lan.de> <56272C1C.8040007@samsung.com>
 <562765F3.9010306@osg.samsung.com> <56276C0F.4090807@fivetechno.de>
 <56276D1A.1070007@samsung.com>
 <CANAwSgRR6OQ3e8RCxB2DQHJNx_LvOwE9CnmCk1oGJMBUuKfeCg@mail.gmail.com>
Message-ID: <56279267.6030808@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Anand and Markus,

On 10/21/2015 01:46 PM, Anand Moon wrote:

[snip]

>>>>
>>>> Markus,
>>>>
>>>> Can you please test following patch [0] on top of Alim's series? If that
>>>> works then it should either be part of Alim's series or the patches will
>>>> have to wait until that patch lands into mainline. I don't have an eMMC
>>>> to test it in XU4 but I'm pretty confident that it will solve the issue.
>>>
>>>
>>> Hi Javier,
>>>
>>> your patch fixes the issue, reboot works now on U3.
>>>
>> Good to know that.
>> Thanks
>>>
>>> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
>>>
>>> Thanks,
>>> --
>>> Markus
>>>
>>>
>>>>
>>>> Best regards,
>>>>
>>>
> 
> Tested on OdroidXU3 emmc. Reboot success.
> 
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> 

Thanks a lot to both for testing the patch.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
