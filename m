From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 30 Jul 2012 09:24:20 +0800
Subject: [PATCH v2 4/7] ARM: pxa: add devicetree code for irq handling
In-Reply-To: <CAN1soZypgp0N5KwQi3ZT2ama8quk5yPnQEHFABp-CWWh94nrvw@mail.gmail.com>
References: <1343330187-20049-1-git-send-email-zonque@gmail.com>
 <1343330187-20049-5-git-send-email-zonque@gmail.com>
 <CAN1soZwGp=OKsyAy=iL7ZUvxG+VPBm-d==8Q-AiPqNUMoiPz-w@mail.gmail.com>
 <5013B750.6060608@gmail.com>
 <CAN1soZxgw-pu3OQ357Be9Nuk_Ln7B9EjkVWeh5gEXB_y6tO7ig@mail.gmail.com>
 <501551E4.6020806@gmail.com>
 <CAN1soZzAMiduQw+mZLs+bB2E-G5Lrm-TV4tEZKL7vUBUuwj+ig@mail.gmail.com>
 <50158890.8080504@gmail.com>
 <CAN1soZypgp0N5KwQi3ZT2ama8quk5yPnQEHFABp-CWWh94nrvw@mail.gmail.com>
Message-ID: <CAN1soZzuCnaJOBb=GtJETyBCCEZcB1KHjAUZ0OoMR=3q-W=bnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 9:20 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Mon, Jul 30, 2012 at 3:01 AM, Daniel Mack <zonque@gmail.com> wrote:
>>
>> Please check the appended version. What I also changed now is that
>> pxa_init_irq() only really handles non-DT initialization, so we have to
>> care for some details in pxa_dt_irq_init() separately. Also, the map()
>> function still had a bug, which I also fixed.
>>
>>
> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>
> Since "marvell,intc-priority" is appended. Maybe you need to update the DTSI
> file. How about send out the updated v4 patch series? I'll merge it in
> this week.
>
> Regards
> Haojian

I requested for you sending patch since 2 patches in v3 are lost in my
gmail account.

Regards
Haojian
