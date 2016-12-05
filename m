From: jun.nie@linaro.org (Jun Nie)
Date: Mon, 5 Dec 2016 10:35:28 +0800
Subject: [PATCH v2] arm64: dts: zx: support cpu-freq for zx296718
In-Reply-To: <20161202060000.GE7682@vireshk-i7>
References: <1480657956-8140-1-git-send-email-baoyou.xie@linaro.org>
 <CA+DQWkzGOzn1TRa9041Jjksj-=509XWXS_U1uaaJXNydB8Apow@mail.gmail.com>
 <20161202060000.GE7682@vireshk-i7>
Message-ID: <CABymUCPezri5__SOmgx4M_B3W0nDFGw7ZTTSu7TP3LXvXgEJLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-12-02 14:00 GMT+08:00 Viresh Kumar <viresh.kumar@linaro.org>:
> On 02-12-16, 13:58, Baoyou Xie wrote:
>> + Viresh, the author of the bindings.
>>
>> On 2 December 2016 at 13:52, Baoyou Xie <baoyou.xie@linaro.org> wrote:
>>
>> > This patch adds the CPU clock phandle in CPU's node
>> > and uses operating-points-v2 to register operating points.
>> >
>> > So it can be used by cpufreq-dt driver.
>> >
>> > Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
>> > ---
>> >  arch/arm64/boot/dts/zte/zx296718.dtsi | 39 ++++++++++++++++++++++++++++++
>> > +++++
>> >  1 file changed, 39 insertions(+)

Reviewed-by: Jun Nie <jun.nie@linaro.org>

>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> --
> viresh
