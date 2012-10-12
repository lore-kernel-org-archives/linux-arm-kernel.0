From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 12 Oct 2012 20:48:56 +0530
Subject: [PATCH V2 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <1350053897.10584.172.camel@smile>
References: <142ef9170a2c69657d8a05ac127a9970d7b04965.1350051925.git.viresh.kumar@linaro.org>
 <9688d98010716880c1bbd966ead312c446282204.1350051925.git.viresh.kumar@linaro.org>
 <1350053897.10584.172.camel@smile>
Message-ID: <CAKohponS+mkj6rN6hzJC1FrbpSS+jWZBii4xQgN+4z2h=zFTWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 October 2012 20:28, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, 2012-10-12 at 20:01 +0530, Viresh Kumar wrote:

>> +     if (last_dw) {
>> +             if ((last_bus_id == param) && (last_dw == dw))
>> +                     return false;
>> +     }

> Just came to my mind.
> dw can't be NULL, can't it?
> Then
> if (last_dw) {
> ...
> }
> is unneeded.

dw can't be but last_dw can be, which we are making NULL when
we find a channel :)

You are already drunk.

--
viresh
