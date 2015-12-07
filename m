From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Mon, 7 Dec 2015 20:44:16 +0800
Subject: [PATCH 2/2] ARM64: dts: mt8173: Add CPU OPP, clock and regulator
 supply properties
In-Reply-To: <20151207100700.GH3294@ubuntu>
References: <1449305584-414-1-git-send-email-pi-cheng.chen@linaro.org>
 <1449305584-414-3-git-send-email-pi-cheng.chen@linaro.org>
 <20151207100700.GH3294@ubuntu>
Message-ID: <CALx668Vf73vwScD+_5JbuCT7yGrZ9PviHfy0zh6vyb_9m-M7LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 7, 2015 at 6:07 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 05-12-15, 16:53, Pi-Cheng Chen wrote:
>> +     cluster0_opp: opp_table0 {
>> +             compatible = "operating-points-v2";
>> +             opp-shared;
>> +             opp00 {
>
> These have to named like: opp at 50700000, look at linux-next for this.

Will do it.

Thanks,
Pi-Cheng

>
> --
> viresh
