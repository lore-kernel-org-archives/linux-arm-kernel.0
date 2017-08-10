From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 10 Aug 2017 15:04:16 +0800
Subject: [linux-sunxi] [PATCH 1/3] arm64: allwinner: a64: add ethernet0
 alias for BPi M64 EMAC node
In-Reply-To: <660391B7-FD1B-44BC-98AF-4CA99DCEBB0B@aosc.io>
References: <20170722022852.7868-1-icenowy@aosc.io>
 <20170722022852.7868-2-icenowy@aosc.io>
 <CAGb2v64DVdFU37V422KfT5zUFN7c6dXyLFBukZegbAuUKZmJBA@mail.gmail.com>
 <660391B7-FD1B-44BC-98AF-4CA99DCEBB0B@aosc.io>
Message-ID: <CAGb2v66bR+kOBR3qwHkLdBCuzPdGpiCrgfXQWr0anYADCD6VmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 12:40 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> ? 2017?8?10? GMT+08:00 ??11:56:02, Chen-Yu Tsai <wens@csie.org> ??:
>>Hi,
>>
>>On Sat, Jul 22, 2017 at 10:28 AM, Icenowy Zheng <icenowy@aosc.io>
>>wrote:
>>> The Banana Pi M64 board uses the A64 chip's EMAC to provide Ethernet
>>> link.
>>>
>>> Add the ethernet0 alias in the device tree, in order to let U-Boot
>>> generate a MAC address from the chip's SID.
>>>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>
>>As mentioned in the discussion of the cover letter of this series,
>>we'd really like to move this to fixes for 4.13.
>>
>>I'd like to move forward on this soon. Can I just do a wholesale
>>rewrite of the commit message along the lines of the following
>>example, and move the 3 patches to fixes for 4.13?
>
> Yes.

Done.

ChenYu
