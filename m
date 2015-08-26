From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Wed, 26 Aug 2015 09:25:29 +0800
Subject: [RESEND PATCH 0/3 v6] Add Mediatek MT8173 cpufreq driver
In-Reply-To: <1617873.VRHfat3V76@vostro.rjw.lan>
References: <1439803465-19683-1-git-send-email-pi-cheng.chen@linaro.org>
 <CALx668VWg2xVxzy8P7f5QFWRzm+TDJXUghL-_rbvRLsLYjtnng@mail.gmail.com>
 <1617873.VRHfat3V76@vostro.rjw.lan>
Message-ID: <CALx668UvkYhLoU8rxLG70RqTzsnaiV5-ybDYTKqb4MEJS8pmRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On Wed, Aug 26, 2015 at 7:01 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, August 25, 2015 10:10:44 AM Pi-Cheng Chen wrote:
>> On Mon, Aug 17, 2015 at 5:24 PM, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
>> > MT8173 is a ARMv8 based SoC with 2 clusters. All CPUs in a single cluster
>> > share the same power and clock domain. This series tries to add cpufreq support
>> > for MT8173 SoC. The v6 of this series is resent with Acks added.
>>
>> Hi Rafael,
>>
>> Not sure if I has missed the merge window.
>> Do I have chance to have this series merged for 4.3?
>
> Yes, it should make it.
>
>> Would you please take [1,2] of this series?

Thanks.

>
> I'm not sure what you mean.  Are you withdrawing the [3/3]?

The [3/3] is based on Mediatek SoC maintainer tree[1] and the patch which
introduce a new clock type[2] consumed by MT8173 cpufreq driver. So it will
cause some conflicts if it goes through your tree. I am not sure how this
should be handled, but should it be merged through Mediatek SoC maintainer
tree?

@Matthias?

Thanks

Best Regards,
Pi-Cheng

[1] https://github.com/mbgg/linux-mediatek.git v4.2-next/arm64
[2] http://article.gmane.org/gmane.linux.kernel/2021379

>
> Thanks,
> Rafael
>
