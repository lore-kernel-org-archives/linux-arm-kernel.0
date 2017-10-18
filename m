From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 18 Oct 2017 15:38:50 +0200
Subject: [PATCH v6 5/5] arm: dts: stm32: remove useless clocksource nodes
In-Reply-To: <CABGGisx1mrf8xSWAXSm9sevE16HgCT72RhcpH6J44ECQnCd3Jw@mail.gmail.com>
References: <1508331506-23782-1-git-send-email-benjamin.gaignard@linaro.org>
 <1508331506-23782-6-git-send-email-benjamin.gaignard@linaro.org>
 <CABGGisx1mrf8xSWAXSm9sevE16HgCT72RhcpH6J44ECQnCd3Jw@mail.gmail.com>
Message-ID: <CA+M3ks7RYx5nXspXtgo7OhOdxNZuJztUwiU+m=qJ=5sAmZhudQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-18 15:21 GMT+02:00 Rob Herring <robh@kernel.org>:
> On Wed, Oct 18, 2017 at 7:58 AM, Benjamin Gaignard
> <benjamin.gaignard@linaro.org> wrote:
>> 16 bits timers aren't accurate enough to be used as
>> clocksource, remove them from stm32f4 and stm32f7 devicetree.
>
> They aren't useful for anything? Zephyr? u-boot?

I have check with the teams and timers (either 16 or 32 bits) are not
used by zephyr or u-boot

>
> Rob
