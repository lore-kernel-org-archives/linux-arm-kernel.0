From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 27 Apr 2015 09:48:15 -0600
Subject: [PATCH 01/11] coresight-etm4x: Adding CoreSight ETM4x driver
In-Reply-To: <1429890108.5211.8.camel@mm-sol.com>
References: <1429742451-11465-1-git-send-email-mathieu.poirier@linaro.org>
 <1429742451-11465-2-git-send-email-mathieu.poirier@linaro.org>
 <1429890108.5211.8.camel@mm-sol.com>
Message-ID: <CANLsYky6TZhZ=JZuoBxU4dNRWVPYGUj6joMfi+dD9zjaokRE0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 April 2015 at 09:41, Ivan T. Ivanov <iivanov@mm-sol.com> wrote:
>
> On Wed, 2015-04-22 at 16:40 -0600, Mathieu Poirier wrote:
>>
>
>> +static struct amba_id etm4_ids[] = {
>> +       {       /* ETM 4.0 - Hi6220 board */
>> +               .id     = 0x0003b95d,
>> +               .mask   = 0x0003ffff,
>> +               .data   = "ETM 4.0",
>> +       },
>> +       {       /* ETM 4.0 - Juno board */
>> +               .id     = 0x000bb95e,
>> +               .mask   = 0x000bffff,
>
> Mask looks suspicious.

Can you please expand the "suspicious" part ?

>
> Regards,
> Ivan
>
>
