From: fu.wei@linaro.org (Fu Wei)
Date: Sun, 7 Feb 2016 10:02:09 +0800
Subject: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
In-Reply-To: <56B641A9.3040801@codeaurora.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <56B23883.7000501@codeaurora.org>
 <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
 <56B23E99.1030604@codeaurora.org>
 <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
 <56B2423B.1020109@codeaurora.org>
 <CADyBb7uULCn97ea19zH8dB4QX1QA8=AXL94d6gXgFxXM8haBNA@mail.gmail.com>
 <56B24642.8090105@codeaurora.org>
 <CADyBb7s_QeU=pYqN9G+5WMtx-L+=QC6uZR6N6ZWPOixnkHzPjw@mail.gmail.com>
 <56B24AB5.3070001@codeaurora.org>
 <CADyBb7usPpY=YLjecXce63zY5e1tniPLmNsVY=8CJHJsCqBgQw@mail.gmail.com>
 <56B2DEE4.7060901@roeck-us.net>
 <CADyBb7unAHEOMfruWS82RkHK6uwPAWCxUx9jqzSkiHU4LHDSeA@mail.gmail.com>
 <56B4B4E2.40105@roeck-us.net>
 <CADyBb7sP=d+BWOdmNEAs38yRcmXVjYsFX=XNffNpGqfybpxTfQ@mail.gmail.com>
 <56B5363D.20200@roeck-us.net>
 <CADyBb7vRKjDoeOfH=3Uwz+D0xyXaC9cM4ZSEO+MwL8Gw5T-Umg@mail.gmail.com>
 <56B641A9.3040801@codeaurora.org>
Message-ID: <CADyBb7vDUpUHtU13A8C-hkBP=oo=KN_HTARJ0FKVVET9gnwtWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 February 2016 at 02:55, Timur Tabi <timur@codeaurora.org> wrote:
> Fu Wei wrote:
>>
>> if (action) {
>>          wdd->min_timeout = 1;
>>          wdd->max_timeout = U32_MAX / gwdt->clk;
>> } else {
>>          wdd->min_timeout = 2;
>>          wdd->max_timeout = U32_MAX / gwdt->clk * 2;
>> }
>
>
> Why would the minimum timeout be 2?  You can program WOR to timeout in half
> a second, can't you?

Yes, I think we can.
you are right, will fix that.

>
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the
> Code Aurora Forum, hosted by The Linux Foundation.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
