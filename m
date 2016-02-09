From: fu.wei@linaro.org (Fu Wei)
Date: Wed, 10 Feb 2016 01:47:28 +0800
Subject: [PATCH v11 4/4] Watchdog: introduce ARM SBSA watchdog driver
In-Reply-To: <56BA244E.1020402@codeaurora.org>
References: <1455037240-16192-1-git-send-email-fu.wei@linaro.org>
 <1455037240-16192-5-git-send-email-fu.wei@linaro.org>
 <56BA244E.1020402@codeaurora.org>
Message-ID: <CADyBb7sqKiFfrwkKUYOAXY3JCZzEM2jtR3Xac_ihafxf_McsLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timur,

On 10 February 2016 at 01:39, Timur Tabi <timur@codeaurora.org> wrote:
> fu.wei at linaro.org wrote:
>
>> +               if (!action)
>> +                       dev_warn(dev, "fall back to signle stage
>> mode.\n");
>
>
> "falling back to single stage mode"

Thanks for your correction.  :-)
Will fixed it

>
> Acked-by: Timur Tabi <timur@codeaurora.org>
>

Thanks, will add this

> The whole "calculate the timeouts different if 'action' is enabled" seems
> clunky to me, but I can't think of a better way to handle it.
>
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum, a Linux Foundation collaborative project.



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
