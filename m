From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Jul 2014 10:31:50 +0100
Subject: [RFC 1/4] ARM: tegra: Move SoC drivers to drivers/soc/tegra
In-Reply-To: <CAOesGMjgNZ0hvWy0p1fh36gOMfBVd-uJSf=AWUsr9GdrrErtyw@mail.gmail.com>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <53AEF81D.3080408@ti.com> <20140628204025.GA16415@ulmo>
 <7497427.LQy8pJts8f@wuerfel>
 <CAOesGMjgNZ0hvWy0p1fh36gOMfBVd-uJSf=AWUsr9GdrrErtyw@mail.gmail.com>
Message-ID: <20140717093149.GB3180@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 08:31:00PM +0100, Olof Johansson wrote:
> [ Gee, I had completely missed this thread because nobody bothered to
> cc me. Seems to be standard procedure on 64-bit these days. :( ]

Just to clarify this point, as per prior agreement I'm expecting the
arm-soc guys to help reviewing/merging arm64-soc as well, even though
there are no arch/arm64/{mach,plat}-* directories. That means that
arm-soc folks should also be cc'ed on such patches.

However, the "ARM SUB-ARCHITECTURES" MAINTAINERS entry does not mention
arm at kernel.org (neither Olof nor Arnd). Was this not meant as an arm-soc
email alias?

-- 
Catalin
