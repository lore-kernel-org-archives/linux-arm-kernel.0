From: fkan@apm.com (Feng Kan)
Date: Tue, 12 Aug 2014 09:20:50 -0700
Subject: [PATCH Resend 0/2] arm64: Add PMU node for APM X-Gene Storm SoC
In-Reply-To: <CALrVBkumLjUZMsfWTn3e_5U=jDFerx0LLzESiuNPZrnBVVfgQg@mail.gmail.com>
References: <1407800853-3149-1-git-send-email-fkan@apm.com>
 <CALrVBkumLjUZMsfWTn3e_5U=jDFerx0LLzESiuNPZrnBVVfgQg@mail.gmail.com>
Message-ID: <CAL85gmDw3-yacob+t+DcBU2qNhTUSj=cTBkv7kNc9ocTb+=FCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 8:47 PM, Anup Patel <anup.patel@linaro.org> wrote:
> On 12 August 2014 05:17, Feng Kan <fkan@apm.com> wrote:
>> This patch series adds PMU node for APM X-Gene's Potenza CPU.
>> Potenza CPU PMU is compatible with ARMv8-PMUv3.
>>
>> I have remove the previous notice regarding the dependancy on the GIC driver
>> from the commit message.
>>
>> Feng Kan (1):
>>   dt-bindings: Add Potenza PMU binding
>>
>> Vinayak Kale (1):
>>   arm64: dts: Add PMU node for APM X-Gene Storm SOC
>>
>>  Documentation/devicetree/bindings/arm/pmu.txt | 1 +
>>  arch/arm64/boot/dts/apm-storm.dtsi            | 5 +++++
>>  2 files changed, 6 insertions(+)
>>
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> Hi Feng,
>
> Please follow proper protocol when resending patchset originally
> authored by someone else.
> (http://comments.gmane.org/gmane.linux.ports.arm.kernel/310795)
I will retract this patch and reauthor it. The person originally started the
patch has left the company. I will take over to resubmit it.


>
> Also, I see that original patchset clearly states that second patch
> depends on a GIC patch [1] authored by you:
>
> [1]- https://lkml.org/lkml/2014/2/27/605
> (irqchip:gic: change access of gicc_ctrl register to read modify write)
>
> I have recently posted RFC patch for PMU support in KVM ARM64
> which also requires your GIC patch for APM X-Gene.
>
> Regards,
> Anup
