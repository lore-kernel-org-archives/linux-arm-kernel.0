From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 2 Jun 2017 12:02:25 +0530
Subject: [PATCH v5 04/11] arm64: dts: Initial DTS files for Broadcom
 Stingray SOC
In-Reply-To: <abeca9ac-487c-b6dc-1397-4134b0442909@gmail.com>
References: <1495790704-2438-1-git-send-email-anup.patel@broadcom.com>
 <1495790704-2438-5-git-send-email-anup.patel@broadcom.com>
 <abeca9ac-487c-b6dc-1397-4134b0442909@gmail.com>
Message-ID: <CAALAos-YQdr3dwjMDj-upSQMQbE6EHO8aXjjwTdCuTEgM+CR0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 2, 2017 at 11:07 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
> On 05/26/2017 02:24 AM, Anup Patel wrote:
>> The Broadcom Stingray SoC is a new member in Broadcom iProc
>> SoC family.
>>
>> This patch adds initial DTS files for Broadcom Stingray SoC
>> and two of its reference boards (bcm958742k and bcm958742t).
>>
>> We have lot of reference boards and large number of devices
>> in Broadcom Stingray SoC so eventually we will have quite
>> a few DTS files for Stingray. To tackle, we have added a
>> separate directory for Stingray DTS files.
>
> So I was going to apply this, but...
>
>
>> +     scr {
>> +             compatible = "simple-bus";
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             ranges = <0x0 0x0 0x61000000 0x05000000>;
>
> So you corrected the ranges property here...
>
>> +
>> +             gic: interrupt-controller at 63c00000 {
>
> but you kept the original unit address here, which does not match the
> reg property, could you fix that through your entire submission?

Thanks for catching. I quickly update this and send revised patchset.

Regards,
Anup
