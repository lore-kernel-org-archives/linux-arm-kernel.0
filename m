From: linuxzsc@gmail.com (Richard Zhao)
Date: Sat, 26 May 2012 20:50:44 +0800
Subject: [PATCH v3 00/12] add imx usb driver for mx28/6x
In-Reply-To: <201205261337.59500.marex@denx.de>
References: <1337912665-16615-1-git-send-email-richard.zhao@freescale.com>
 <201205261337.59500.marex@denx.de>
Message-ID: <CANg6MZhKkjre_5wCj70Zajc2s51hw88t=K-eemmN+DVePEQD5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Sat, May 26, 2012 at 7:37 PM, Marek Vasut <marex@denx.de> wrote:
> Dear Richard Zhao,
>
>> The work is based on ?ci13xxx rework done by Alexander Shishkin.
>>
>> Status:
>> ? - this version only support host
>> ? - usbotg controler works at host role
>>
>> Changes since V2:
>> ? - Rebase to Alex's tree
>> ? - Use regulator to control vbus power
>> ? - Remove ARCH check in Kconfig, but add OF_DEV check.
>> ? - Other changes according laster version comments.
>
> Is there any git tree with these patches?
https://github.com/riczhao/kernel-imx/commits/topics/usb

> Also, on top of what tree are these
> based on please?
They're based on Alex's tree.
>
> Thanks!
>
> Best regards,
> Marek Vasut
