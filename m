From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 8 Nov 2014 23:55:49 +0400
Subject: [PATCH v1 0/3] Transition pxa25x clock to common clocks
In-Reply-To: <87lhnlwqm4.fsf@free.fr>
References: <1414941415-13146-1-git-send-email-robert.jarzmik@free.fr>
 <CALT56yOCBN1NAfNw=vThVZ_o=ONGOTvzKHBH5tCTQShJY0wkrQ@mail.gmail.com>
 <87lhnlwqm4.fsf@free.fr>
Message-ID: <CALT56yNOXq-ssvsjafz=ae+uWv1GyscoQ3RQ_h--i740zm4trA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-08 20:26 GMT+03:00 Robert Jarzmik <robert.jarzmik@free.fr>:
> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:
>
>> Hello,
>> Tested in qemu (pxa25x target).
>>
>> 2) sa1100-rtc could not find a clock and thus failed to be probed.
>> 4) Got an issue with IrDA driver - it gets -ENODEV for UARTCLK clock
>
> Hi Dmitry,
>
> Would you mind retesting with the patch in [1] applied to see if points 2 and 4
> are fixed ? Alternatively you can refetch from the github tree, I included that
> incremental patch there too.
>
> If it works correctly for you, could I have your Tested-by ? If not, tell me and
> I'll try to figure out what's wrong.

Tested in qemu, everything works fine. I will test on the real hardware tomorow.

BTW: It looks like pxa27x also shows the same behaviour wrt. sa1100-rtc and
pxa2xx-ir (after reverting a revert).

-- 
With best wishes
Dmitry
