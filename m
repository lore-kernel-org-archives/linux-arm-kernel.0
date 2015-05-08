From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 8 May 2015 07:12:48 -0600
Subject: [PATCH v3 01/11] coresight-etm4x: Adding CoreSight ETM4x driver
In-Reply-To: <1431073649.21307.12.camel@mm-sol.com>
References: <1430926047-9125-1-git-send-email-mathieu.poirier@linaro.org>
 <1430926047-9125-2-git-send-email-mathieu.poirier@linaro.org>
 <1431073649.21307.12.camel@mm-sol.com>
Message-ID: <CANLsYkxoZ62qeS91NbQZYwz-fx2qNdY+Ygw6NLbLgxcoqmkc-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 May 2015 at 02:27, Ivan T. Ivanov <iivanov@mm-sol.com> wrote:
>
> Hi Mathieu,
>
> On Wed, 2015-05-06 at 09:27 -0600, Mathieu Poirier wrote:
>>
>> +static struct amba_id etm4_ids[] = {
>> +       {       /* ETM 4.0 - Juno board */
>> +               .id     = 0x000bb95e,
>> +               .mask   = 0x000fffff,
>> +               .data   = "ETM 4.0",
>> +       },
>> +       { 0, 0},
>> +};
>> +
>>
>
> Any particular reason to remove device ID for the
> Hi6220 board? It happens to be the same ID used in
> Qualcomm 8x16 ETM components.

Efforts to push support for the Hi6220 board upstream have been
abandoned, hence the decision to remove the entry.  Apologies for the
inconvenience, I will add it back.

Mathieu

>
> Regards,
> Ivan
