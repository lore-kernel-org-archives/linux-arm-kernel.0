From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 8 May 2015 08:13:22 -0600
Subject: [PATCH v2 2/2] arm64: dts: qcom: Add msm8916 CoreSight components
In-Reply-To: <1431092877.21307.18.camel@linaro.org>
References: <1431012969-16338-1-git-send-email-ivan.ivanov@linaro.org>
 <1431012969-16338-3-git-send-email-ivan.ivanov@linaro.org>
 <CANLsYkzNXBH0d6v1Ny_JwpW6NcKr9v0oAi9K3YfipwDgHWfMMA@mail.gmail.com>
 <1431092877.21307.18.camel@linaro.org>
Message-ID: <CANLsYkyNYQf80c+8uMbZDr=kQ2YEOqy2aS8muEJsLsanDRGLOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 May 2015 at 07:47, Ivan T. Ivanov <ivan.ivanov@linaro.org> wrote:
>
> On Fri, 2015-05-08 at 07:38 -0600, Mathieu Poirier wrote:
>> On 7 May 2015 at 09:36, Ivan T. Ivanov ivanov at linaro.org> wrote:
>> > Add initial set of CoreSight components found on Qualcomm's 8x16 chipset.
>> >
>> >
>> > +       replicator at 824000 {
>> > +               compatible = "qcom,coresight-replicator", "arm,primecell";
>>
>> Shouldn't it be "qcom,coresight-replicator1x" ?
>>
>
>
>
> True, I still wonder, why we have to have this compatible string?
> Drivers are probed by amba_id and "arm,primecell", after all.
>

Drivers have their own compatible strings for historical reasons,
something I've been meaning to fix for a long time now...

> Thanks,
> Ivan
