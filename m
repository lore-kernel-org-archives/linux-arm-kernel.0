From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Mon, 17 Jun 2013 14:16:02 +0530
Subject: [PATCH v2 06/10] clk: exynos5420: register clocks using common
 clock framework
In-Reply-To: <CAL1qeaFS=MMHJj8TP4vX8-KeXNo0W_EjvhrLsb5=YNsnaqOVXw@mail.gmail.com>
References: <1370516488-25860-10-git-send-email-chander.kashyap@linaro.org>
 <1371218572-8993-1-git-send-email-chander.kashyap@linaro.org>
 <1371218572-8993-7-git-send-email-chander.kashyap@linaro.org>
 <CAL1qeaFS=MMHJj8TP4vX8-KeXNo0W_EjvhrLsb5=YNsnaqOVXw@mail.gmail.com>
Message-ID: <CANuQgHFwdyGdpBAD8bnQmyyGDK2=3qa7yGQsK=54n6fvocrNkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 June 2013 22:56, Andrew Bresticker <abrestic@google.com> wrote:
> Hi Chander,
>
>> +       [Core Clocks]
>> +
>> +  Clock                        ID
>> +  ----------------------------
>> +
>> +  oscclk               1
>
> I know the UM refers to this as 'oscclk', but could we instead call
> this 'fin_pll' to be consistent with Exynos 4 and Exynos 5250?
I will rename it to make consistent.
Thanks.
>
> Thanks,
> Andrew



--
with warm regards,
Chander Kashyap
