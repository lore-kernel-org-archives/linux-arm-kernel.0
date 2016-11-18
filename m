From: nm@ti.com (Nishanth Menon)
Date: Thu, 17 Nov 2016 22:34:24 -0600
Subject: [RFC 6/6] ARM: dts: am57xx-beagle-x15-common: enable etnaviv
In-Reply-To: <CAOCHtYh8QebrYA2ioaXgURdc47QY4x+EwZLBXLLGP1-k7eAMmw@mail.gmail.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <20161118024436.13447-6-robertcnelson@gmail.com>
 <e69a797c-bec3-2243-5c19-9d7633092369@ti.com>
 <CAOCHtYiUz1cjYw9nNa4YZGtzNVgSgjEa=4Lqiktz07rszsSksw@mail.gmail.com>
 <3eb346ad-1675-e613-93ef-bd2d07bf2ab8@ti.com>
 <CAOCHtYh8QebrYA2ioaXgURdc47QY4x+EwZLBXLLGP1-k7eAMmw@mail.gmail.com>
Message-ID: <82862612-8d19-d58c-ca24-292c041abf65@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2016 10:26 PM, Robert Nelson wrote:
[...]
> Oh yeah, defintely, we can move gpu-subsystem to the base dra7.dtsi,
> as the whole dra.dtsi family has a gc320 and then the board device
> tree can enable it via:
>
> &bb2d {
>        status = "okay";
> };

Yep, thanks.

-- 
Regards,
Nishanth Menon
