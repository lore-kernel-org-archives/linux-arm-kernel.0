From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 Mar 2012 20:40:49 -0800
Subject: [PATCH 0/3] arm: tegra: dts: USB Updates for Tegra legacy mode /
 OTG
In-Reply-To: <CAPnjgZ1rXEGbi3m3HeWiUxG_TbmUug0C0QZgb7_9Eiz-xPMHwg@mail.gmail.com>
References: <1328288172-8059-1-git-send-email-sjg@chromium.org>
 <74CDBE0F657A3D45AFBB94109FB122FF178E5D2FF5@HQMAIL01.nvidia.com>
 <CAPnjgZ1rXEGbi3m3HeWiUxG_TbmUug0C0QZgb7_9Eiz-xPMHwg@mail.gmail.com>
Message-ID: <CAOesGMjXkFOxfp9fnhwKFZSoUJmHObk7FaiaNNj2NSyyNMTjkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2012 at 7:16 PM, Simon Glass <sjg@chromium.org> wrote:
> +Olof
>
> Hi,
>
> On Fri, Feb 3, 2012 at 11:59 AM, Stephen Warren <swarren@nvidia.com> wrote:
>> Simon Glass wrote at riday, February 03, 2012 9:56 AM:
>>> This little series brings in some bindings that seem useful for U-Boot.
>>>
>>> I am working mostly in U-Boot, but since there is no shared .dts repo
>>> I was asked to commit these changes to the kernel. I do not propose to
>>> update the Linux USB drivers to match.
>>
>> I think the series looks reasonable, so:
>>
>> Acked-by: Stephen Warren <swarren@nvidia.com<>
>>
>> (I note that the kernel's USB driver for USB1 doesn't attempt to clear
>> legacy mode; I wonder how we're getting away with that. Perhaps it's
>> only been tested with a bootloader that's already cleared legacy mode)
>>
>
> How does this series get picked up, please?

It drowned in the patch floods you've been sending, and it wasn't
addressed directly to me so I ignored it.

Please resend and I'll apply.


Thanks,

-Olof
