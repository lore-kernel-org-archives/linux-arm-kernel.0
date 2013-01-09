From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 9 Jan 2013 11:42:06 -0500
Subject: [PATCH v5 12/12] ARM: KVM: Add VGIC configuration option
In-Reply-To: <50ED7083.5060401@mvista.com>
References: <20130108184116.46558.3558.stgit@ubuntu>
 <20130108184245.46558.83229.stgit@ubuntu>
 <50ED7083.5060401@mvista.com>
Message-ID: <CANM98qLWrOEram-EN1wasG=PctUzsdZv-ctryNx70auyk39XSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 9, 2013 at 8:28 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
>
> On 08-01-2013 22:42, Christoffer Dall wrote:
>
>> From: Marc Zyngier <marc.zyngier@arm.com>
>
>
>> It is now possible to select the VGIC configuration option.
>
>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>> ---
>>   arch/arm/kvm/Kconfig |    8 ++++++++
>>   1 file changed, 8 insertions(+)
>
>
>> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
>> index 05227cb..d32e33f 100644
>> --- a/arch/arm/kvm/Kconfig
>> +++ b/arch/arm/kvm/Kconfig
>> @@ -51,6 +51,14 @@ config KVM_ARM_MAX_VCPUS
>>           large, so only choose a reasonable number that you expect to
>>           actually use.
>>
>> +config KVM_ARM_VGIC
>> +        bool "KVM support for Virtual GIC"
>
>
>    Please indent with tab, as below.
>
>

fixed both, thanks.
