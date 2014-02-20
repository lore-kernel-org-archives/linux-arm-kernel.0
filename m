From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Feb 2014 18:58:05 +0000
Subject: [PATCH 2/3] arm64: Add Kconfig option for Samsung GH7 SoC family
In-Reply-To: <CAOesGMhfhdqqb4hJ0hC5HbSWWMQc0FDaaZYO0rZ1cdFtuRgdig@mail.gmail.com>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
 <5302B306.8090503@samsung.com>
 <CAOesGMhnUDcUL7hREV=EYEGr5YG-ZLL6v9NiGcrBr6477WfdyQ@mail.gmail.com>
 <6032891.ndY8FikAMY@wuerfel>
 <CALAqxLX6STNqUeVO2G18bm_HKabpoRxZTa3uK6i-JP97zEYVZg@mail.gmail.com>
 <CAOesGMjLR3PGXeyJPAvGwam4yK97+vnDfq5MVutJz75aKPX8gw@mail.gmail.com>
 <CALAqxLU7ehHfvQa58HpdzojRU-2zhNpEgkr9KEJ3cf550WcnWw@mail.gmail.com>
 <CAOesGMjSjzZ4iX3NVA6eS4LHJF2MQQ=KJpNgKWikJb6YkQxNpQ@mail.gmail.com>
 <20140220112248.GC32456@localhost>
 <CAOesGMhfhdqqb4hJ0hC5HbSWWMQc0FDaaZYO0rZ1cdFtuRgdig@mail.gmail.com>
Message-ID: <20140220185805.GI7651@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 05:09:59PM +0000, Olof Johansson wrote:
> On Thu, Feb 20, 2014 at 3:22 AM, Catalin Marinas
> > Two additional points:
> >
> > 1. Single arm64 defconfig file covering everything
> > 2. Modules rather than built-in by default where possible (especially
> >    for server platforms)
> 
> Sounds good to me. Are you also willing to pick up one defconfig per
> vendor (but not more)? I think it's been useful to have those on arm,
> even on multiplatform kernels. We used them on powerpc as well, where
> we had a two-layer approach (ppc64_defconfig and per-platform configs,
> pseries/iseries/pasemi/g5/cell).

Initially I would keep a single defconfig with everything just to get
wider coverage of single Image. Later on, if just deselecting config
entries doesn't work, we can revisit per-vendor defconfigs.

-- 
Catalin
