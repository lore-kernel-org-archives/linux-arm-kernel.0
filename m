From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 18 Mar 2014 10:19:10 +0530
Subject: [PATCH] ARM: davinci: fix DT booting with default defconfig
In-Reply-To: <CAGa+x84fYJAS3y+SHbZP2DULujWs0una590XR25QSn3azyR5xQ@mail.gmail.com>
References: <1394818228-1846-1-git-send-email-khilman@linaro.org>	<53268151.7030409@ti.com>
 <CAGa+x84fYJAS3y+SHbZP2DULujWs0una590XR25QSn3azyR5xQ@mail.gmail.com>
Message-ID: <5327D046.3080800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 March 2014 03:01 AM, Kevin Hilman wrote:
> On Sun, Mar 16, 2014 at 10:00 PM, Sekhar Nori <nsekhar@ti.com> wrote:
>> On Friday 14 March 2014 11:00 PM, Kevin Hilman wrote:
>>> Davinci boards tend to have older booloaders without DTB support.
>>> Enable appended DTB support by default to allow DT booting on older
>>> platforms.  While there, also enable /proc/device-tree support for
>>> easy verification of DT boot.
>>>
>>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>>> ---
>>> Sekhar, this applies on top of your latest defconfig cleanup queued
>>> for v3.15 and validated with DT and legacy boot on DA850 EVM.
>>
>> Thanks Kevin. If you will take this directly through ARM-SoC:
>>
>> Acked-by: Sekhar Nori <nsekhar@ti.com>
> 
> I'd prefer if you just take it along with your changes.  Maybe as a
> fix for v3.15-rc since it fixes some booting issues with legacy
> booting on top of your defconfig cleanup.

Okay sure.

Thanks,
Sekhar
