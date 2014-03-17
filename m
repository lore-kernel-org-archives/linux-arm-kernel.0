From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 17 Mar 2014 14:31:09 -0700
Subject: [PATCH] ARM: davinci: fix DT booting with default defconfig
In-Reply-To: <53268151.7030409@ti.com>
References: <1394818228-1846-1-git-send-email-khilman@linaro.org>
 <53268151.7030409@ti.com>
Message-ID: <CAGa+x84fYJAS3y+SHbZP2DULujWs0una590XR25QSn3azyR5xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 16, 2014 at 10:00 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Friday 14 March 2014 11:00 PM, Kevin Hilman wrote:
>> Davinci boards tend to have older booloaders without DTB support.
>> Enable appended DTB support by default to allow DT booting on older
>> platforms.  While there, also enable /proc/device-tree support for
>> easy verification of DT boot.
>>
>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>> ---
>> Sekhar, this applies on top of your latest defconfig cleanup queued
>> for v3.15 and validated with DT and legacy boot on DA850 EVM.
>
> Thanks Kevin. If you will take this directly through ARM-SoC:
>
> Acked-by: Sekhar Nori <nsekhar@ti.com>

I'd prefer if you just take it along with your changes.  Maybe as a
fix for v3.15-rc since it fixes some booting issues with legacy
booting on top of your defconfig cleanup.

Kevin
