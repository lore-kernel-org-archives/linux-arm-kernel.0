From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 May 2015 07:52:46 -0600
Subject: [PATCH v3] arm64: dts: qcom: Add msm8916 CoreSight components
In-Reply-To: <1432018984.29174.2.camel@linaro.org>
References: <1431333119-13626-1-git-send-email-ivan.ivanov@linaro.org>
 <CANLsYkyKrtyMicsNs2CDd4=GfrQJOPJkAqSUiTB=5hRs3+d=tQ@mail.gmail.com>
 <7F8B0480-06A8-4381-90C8-3F2A35F14FCD@codeaurora.org>
 <1432018984.29174.2.camel@linaro.org>
Message-ID: <CANLsYkwTm+8B-ehnC-9MD19MCha_jZU1UCVCev+44eGv_nS50w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 May 2015 at 01:03, Ivan T. Ivanov <ivan.ivanov@linaro.org> wrote:
>
> On Mon, 2015-05-18 at 13:52 -0500, Kumar Gala wrote:
>> >
>> > On May 11, 2015, at 2:21 PM, Mathieu Poirier poirier at linaro.org> wrote:
>> >
>> > On 11 May 2015 at 02:31, Ivan T. Ivanov ivanov at linaro.org> wrote:
>> > > Add initial set of CoreSight components found on Qualcomm's 8x16 chipset.
>> >
>
>> >
>> > Kumar, I'm happy with this DT specification for Coresight.  Since I'm
>> > taking the driver it would likely make more sense for this to go
>> > through my tree.  Could you please have a look and give me your ack?
>>
>> It looks ok, however I don?t see us including this file anywhere, so that?s my only concern.
>>
>
> True. The reason is that 'rpmcc' driver is still in testing phase
> and it is not upstreamed. Once it is ready, I will include this file
> where is appropriate.
>
> Regards,
> Ivan

Very well - as such I won't take the DT patch right away.  Please
re-submit when all the components are ready.
