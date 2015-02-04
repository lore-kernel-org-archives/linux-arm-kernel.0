From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Wed, 4 Feb 2015 14:48:55 +0200
Subject: [PATCH v4 4/6] ARM: dts: Alpine platform binding documentation
In-Reply-To: <54D11B2A.8020507@codeaurora.org>
References: <54d0cd2e.gI5kk97sYr5JVQ9k%tsahee@annapurnalabs.com>
 <54D11B2A.8020507@codeaurora.org>
Message-ID: <CABM=7kngfhRn8EEWXXURgm_pOhm6QqewDydNSqcFoA1BgKbxmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you! will be fixed!
(as well as your comments for the other patches in the set)

On 3 February 2015 at 21:02, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 02/03/15 05:29, Tsahee Zidenberg wrote:
>> +* Alpine CPU resume registers
>> +
>> +The CPU resume register are used to define required resume address after
>> +reset.
>> +
>> +Properties:
>> +- compatible : Should contain "al,al-cpu-resume".
>> +- reg : Offset and length of the register set for the device
>> +
>> +Example:
>> +
>> +cpu_resume {
>> +     compatible = "al,alpine-cpu-resume";
>> +     reg = <0xfbff5ed0 0x30>;
>> +};
>> +
>> +* Alpine System-Fabric Service Registers
>> +
>> +The System-Fabric Service Registers allow various operation on CPU and
>> +system fabric, like powering CPUs off.
>> +
>> +Properties:
>> +- compatible : Should contain "al,al-sysfabric-service".
>
> and syscon?
>
>> +- reg : Offset and length of the register set for the device
>> +
>> +Example:
>> +
>> +nb_service {
>> +        compatible = "al,alpine-sysfabric-service";
>> +        reg = <0xfb070000 0x10000>;
>> +};
>>
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
