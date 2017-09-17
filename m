From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Sun, 17 Sep 2017 15:34:23 +0200
Subject: [PATCH 2/2] arm: dts: stm32: remove useless clocksource nodes
In-Reply-To: <20170915210347.GA1831@mai>
References: <1505375812-19037-1-git-send-email-benjamin.gaignard@linaro.org>
 <1505375812-19037-3-git-send-email-benjamin.gaignard@linaro.org>
 <20170915210347.GA1831@mai>
Message-ID: <CA+M3ks6WjdJ-z5pcfXDk7va5CS0zQ6gud85GGHRS9zh2d6YSuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-09-15 23:03 GMT+02:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
> On Thu, Sep 14, 2017 at 09:56:52AM +0200, Benjamin Gaignard wrote:
>> 16 bits timers aren't accurate enough to be used as
>> clocksource, remove them from stm32f4 and stm32f7 devicetree.
>
> Do you really want to remove the description? The timers are disabled, aren't they?

Yes because they are 16 bits timers and they won't be accepted anymore in
driver's probe function.
