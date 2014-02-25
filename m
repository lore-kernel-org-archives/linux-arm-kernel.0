From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 25 Feb 2014 09:20:59 +0900
Subject: [PATCH 2/3] arm64: Add Kconfig option for Samsung GH7 SoC family
In-Reply-To: <CAOesGMjSjzZ4iX3NVA6eS4LHJF2MQQ=KJpNgKWikJb6YkQxNpQ@mail.gmail.com>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
 <5302B306.8090503@samsung.com>
 <CAOesGMhnUDcUL7hREV=EYEGr5YG-ZLL6v9NiGcrBr6477WfdyQ@mail.gmail.com>
 <6032891.ndY8FikAMY@wuerfel>
 <CALAqxLX6STNqUeVO2G18bm_HKabpoRxZTa3uK6i-JP97zEYVZg@mail.gmail.com>
 <CAOesGMjLR3PGXeyJPAvGwam4yK97+vnDfq5MVutJz75aKPX8gw@mail.gmail.com>
 <CALAqxLU7ehHfvQa58HpdzojRU-2zhNpEgkr9KEJ3cf550WcnWw@mail.gmail.com>
 <CAOesGMjSjzZ4iX3NVA6eS4LHJF2MQQ=KJpNgKWikJb6YkQxNpQ@mail.gmail.com>
Message-ID: <530BE1EB.8070602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/14 18:03, Olof Johansson wrote:

[...]
>
> I.e. I'd be OK with an
> ARCH_EXYNOS/ARCH_TEGRA/ARCH_IMX/ARCH_<whatever>, but I don't think we
> should add more finegrained options than that globally on ARM64, at
> least not until truly proven to be needed. We're trying to push back
> against new per-SoC Kconfig entries on 32-bit as well right now.
>
OK, agreed.

- Kukjin
