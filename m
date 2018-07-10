From: peron.clem@gmail.com (=?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?=)
Date: Tue, 10 Jul 2018 18:05:49 +0200
Subject: [PATCH v7 0/5] Reintroduce i.MX EPIT Timer
In-Reply-To: <c9db3848-378f-8e1e-c194-53d878894716@linaro.org>
References: <20180611155001.3506-1-peron.clem@gmail.com>
 <CAJiuCcf3g2fzrR2_4mthjwKRcyZ8KVPX+EZ5_Uifh2E6TkzusQ@mail.gmail.com>
 <52591c2d-e9df-7078-7cdf-0fd8d06c9ee0@linaro.org>
 <CAJiuCcc-eGRr_RT01dNfhQso5PbXfWy+YZS4PHHcL=_yhA-3Sw@mail.gmail.com>
 <c9db3848-378f-8e1e-c194-53d878894716@linaro.org>
Message-ID: <CAJiuCce7yBA+_s44RboKr9x-Ts5qk4T4vCXyVbVuUUxMSc+ScQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Daniel,


On Tue, 10 Jul 2018 at 17:37, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 10/07/2018 17:22, Cl?ment P?ron wrote:
> > Hi Daniel,
> >
> > On Tue, 10 Jul 2018 at 17:12, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 10/07/2018 16:55, Cl?ment P?ron wrote:
> >>> Hi,
> >>>
> >>> Is there still some remark against merging this ?
> >>
> >> How do you want this to be merged ?
> >>
> >> Shall I take the two patches related to the timer ? Or Ack them ?
> >
> > I'm not an expert on how submitting patches works, it's the first
> > driver I submit.
>
> Ok, so usually this is what happens when there is a set of changes:
>
>  1.  they all touch the same subsystem (eg. drivers/clocksource), you
> just send all the patches to the maintainer(s) + mailing list + related
> people
>
>  2. they touch different subsystems:
>
>    2.1) the changes are not connected (not related together), you have
> to split in smaller parts and send the patches to the right subsystem
> maintainer (so falling back to 1.)
>
>    2.2) the changes are connected:
>
>       2.2.1) Ask all the different subsystem maintainers to acknowledge
> the changes and submit the patches to arm-soc@
>
>       2.2.2) Ask each maintainer to take their part if the changes are
> connected but not interdependent (patches individually won't break the
> system)
>
>
> You are in the 2.2) situation. My question is do you want 2.2.1) or 2.2.2) ?

Thanks for the explanation, I think in 2.2.1 as I still need an Ack
for the "ARM: dts" patch

Regards,
Clement

>
>
> --
>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
