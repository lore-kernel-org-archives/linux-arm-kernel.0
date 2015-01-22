From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 22 Jan 2015 10:48:12 +0100
Subject: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
In-Reply-To: <54C0C4DD.2040302@armadeus.com>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
 <20150121230148.GJ13715@earth.universe> <54C0AFE4.3020701@i2se.com>
 <54C0C4DD.2040302@armadeus.com>
Message-ID: <54C0C75C.30603@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Am 22.01.2015 um 10:37 schrieb S?bastien SZYMANSKI:
> Hello,
>
> On 01/22/2015 09:08 AM, Stefan Wahren wrote:
>> In the meantime i made some bugfixes on these patches. Now i think it
>> would be better to integrate the on-chip regulator driver into the patch
>> series. That would clarify the function of the power driver.
>>
> I was about to resend this series with a poweroff driver for the imx28
> SoCs.

sounds great.

> Should I wait this series get merged?

Yes, please. In the meantime you can use my repo at github (based on
pm+acpi-3.19-rc4):

https://github.com/lategoodbye/linux-mxs-power

>
> I thought adding a poweroff child node like this:
>
> power: power at 80044000 {
> 	...
> 	poweroff: poweroff at 80044100 {
> 		compatible = "fsl,imx28-poweroff";
> 		reg = <0x80044100 0x10>;
> 	};
> 	...
> };

Just a note to your driver it would be nice if it's handles i.MX23 and
i.MX28.

> [...]

Regards Stefan
