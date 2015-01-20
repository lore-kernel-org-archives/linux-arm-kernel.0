From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Tue, 20 Jan 2015 16:47:59 +0800
Subject: [PATCH 1/2] cpufreq-dt: check CPU clock/power domain during
 initializing
In-Reply-To: <CAKohponUfB-RJTwPDMPCGogng8nzc=kwTF56GjGfDSD7MLQuAg@mail.gmail.com>
References: <1420797291-15972-1-git-send-email-pi-cheng.chen@linaro.org>
 <1420797291-15972-2-git-send-email-pi-cheng.chen@linaro.org>
 <CAKohpok7Q3CpMospA=3PAqiLtEERfkAJdHkcH+9GKvYBsof0UQ@mail.gmail.com>
 <CALx668V5TKkx-qGnMjFAspTQ5pu3XsM1012wXsBHvR3CNsuCew@mail.gmail.com>
 <CAKohponUfB-RJTwPDMPCGogng8nzc=kwTF56GjGfDSD7MLQuAg@mail.gmail.com>
Message-ID: <CALx668WCTPZDWigcDyWKy__Lh+LQrEX9fVnqmfWcjZnJWnBiMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2015 at 15:39, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 20 January 2015 at 13:03, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
>> I will also try to add intermediate frequency support in next version.
>
> Sure
>
>> BTW, do you think it's a good idea to add a new device tree binding like
>> intermediate_clock = <&clksys MAINPLL>
>> and so that cpufreq-dt could get the intermediate clock?
>
> Yeah, we need that. I am trying to implement new opp bindings and will
> take care of that. Until that time, use platform data to do that.
>

Got it.
Thanks.

Best Regards,
Pi-Cheng

> --
> viresh
