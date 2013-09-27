From: robherring2@gmail.com (Rob Herring)
Date: Fri, 27 Sep 2013 07:14:02 -0500
Subject: [PATCH 3/6] cpuidle: calxeda: add ecx-2000 support
In-Reply-To: <52454608.6040504@linaro.org>
References: <1380248694-13388-1-git-send-email-robherring2@gmail.com>
 <1380248694-13388-4-git-send-email-robherring2@gmail.com>
 <52454608.6040504@linaro.org>
Message-ID: <CAL_JsqL=L8rZ_2qExR0rWV2Z_OQM-w0vHJhx-Xtid-ozAqghUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 3:47 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 09/27/2013 04:24 AM, Rob Herring wrote:
>>
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Add cpuidle support for Calxeda ecx-2000 SoC.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: linux-pm at vger.kernel.org
>
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks.

> Shall I pick these three patches in my tree ?

No, the highbank changes are dependent on this to go in first.

Rob
