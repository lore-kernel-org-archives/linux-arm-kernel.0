From: sjg@chromium.org (Simon Glass)
Date: Tue, 6 Mar 2012 19:16:43 -0800
Subject: [PATCH 0/3] arm: tegra: dts: USB Updates for Tegra legacy mode /
 OTG
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF178E5D2FF5@HQMAIL01.nvidia.com>
References: <1328288172-8059-1-git-send-email-sjg@chromium.org>
 <74CDBE0F657A3D45AFBB94109FB122FF178E5D2FF5@HQMAIL01.nvidia.com>
Message-ID: <CAPnjgZ1rXEGbi3m3HeWiUxG_TbmUug0C0QZgb7_9Eiz-xPMHwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Olof

Hi,

On Fri, Feb 3, 2012 at 11:59 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Simon Glass wrote at riday, February 03, 2012 9:56 AM:
>> This little series brings in some bindings that seem useful for U-Boot.
>>
>> I am working mostly in U-Boot, but since there is no shared .dts repo
>> I was asked to commit these changes to the kernel. I do not propose to
>> update the Linux USB drivers to match.
>
> I think the series looks reasonable, so:
>
> Acked-by: Stephen Warren <swarren@nvidia.com<>
>
> (I note that the kernel's USB driver for USB1 doesn't attempt to clear
> legacy mode; I wonder how we're getting away with that. Perhaps it's
> only been tested with a bootloader that's already cleared legacy mode)
>

How does this series get picked up, please?

Regards,
Simon

> --
> nvpublic
>
