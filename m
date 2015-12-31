From: dhdang@apm.com (Duc Dang)
Date: Wed, 30 Dec 2015 16:12:12 -0800
Subject: [GIT PULL] arm64: DTS changes for X-Gene platforms queued for v4.5
In-Reply-To: <4175975.EH46H1lqut@wuerfel>
References: <CADaLNDnM463bnMq349q_2XEh2AeGs4yrp-y474wQZ-NCSE0Cqw@mail.gmail.com>
 <4175975.EH46H1lqut@wuerfel>
Message-ID: <CADaLNDn7FZotr_Q9Pvjz5mr1n=ULytesxSRZQwLpFF08D2amaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 3:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 30 November 2015 10:20:50 Duc Dang wrote:
>> DTS changes for X-Gene platforms queued for v4.5
>>
>> This patch set adds DTS entries to support various IPs
>> for X-Gene v1 and X-Gene v2 SoC:
>> - X-Gene v1: Enable support for MMC, USB, GPIO controllers,
>>   I2C controller, L2 Cache topology
>> - X-Gene v2: Enable support for MMC, USB, GPIO controller,
>>   I2C controller (with RTC), PCIe controller with GICv2m MSI,
>>   EDAC, L2 Cache topology, TRNG
>>
>
> Merged into next/dt64.
>
> I see that most of your node names are wrong, please fix them
> in your next update by using the standard node names:
>
>         dwusb -> usb
>         i2c0 -> i2c
>         cfggpio0 -> gpio
>         dwgpio -> gpio
>         ...

Thanks, Arnd.

I changed the node name for I2C and GPIO nodes in the new pull
request. For USB, I still need to keep dwusb name as we need to
maintain backward compatibility with our already released old
bootloader firmware (U-Boot and EFI Tianocore).

>
>         Arnd

Regards,
Duc Dang.
