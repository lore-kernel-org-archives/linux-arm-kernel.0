From: nicolae.rosia@gmail.com (Nicolae Rosia)
Date: Thu, 11 Dec 2014 22:34:10 +0200
Subject: [PATCH v4 0/6] Touchscreen performance related fixes
In-Reply-To: <547C42FF.5010700@ti.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <20141124115116.GA14997@linutronix.de> <547C3A95.30605@ti.com>
 <547C3C19.5090501@linutronix.de> <547C42FF.5010700@ti.com>
Message-ID: <CAH=tA9FO5MCzE274thc-NugCNte6WdyC-Rxc6yfnuR=+6_qMbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Any updates on this series? I don't see it applied in [1] or [2].

[1] https://github.com/RobertCNelson/ti-linux-kernel/commits/ti-linux-3.14.y/drivers/input/touchscreen/ti_am335x_tsc.c
[2] https://github.com/RobertCNelson/ti-linux-kernel/commits/ti-linux-3.14.y-exp/drivers/input/touchscreen/ti_am335x_tsc.c

Regards,
Nicolae Rosia

On Mon, Dec 1, 2014 at 12:29 PM, Vignesh R <vigneshr@ti.com> wrote:
>
> Hi,
>
> On Monday 01 December 2014 03:29 PM, Sebastian Andrzej Siewior wrote:
>> On 12/01/2014 10:53 AM, Vignesh R wrote:
>>> Hi Sebastian,
>>
>> Hi Vignesh,
>>
>>> I fixed the issue that was triggering the WARN_ON(). I think it would be
>>> better if you tested these patches, before I posted them on the
>>> mainline. I don't want to clutter the list with too main versions. Here
>>> is the link to the tree with latest changes:
>>
>> awesome, thank you.
>>
>>>
>>> git clone -b tsc-devel git://git.ti.com/kernel/tsc-adc.git
>>> (tsc-devel branch)
>>
>> I will and let you know.
>>
>>> Please test the above tree and let me know the results.
>>> I will post new version(v5) if there are no issues wrt IIO and TSC
>>> working at the same time.
>>
>> Cool. Were you able to get in touch with someone who has a 5-wire touch?
>
> I have asked Jeff Lance to verify 5-wire touch.
>
> Regards
> Vignesh
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
