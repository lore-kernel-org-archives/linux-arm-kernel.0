From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Jun 2017 21:50:28 +0200
Subject: [PATCH] arm64: defconfig: Enable ARCH_BRCMSTB
In-Reply-To: <20170607165806.11242-1-f.fainelli@gmail.com>
References: <20170607165806.11242-1-f.fainelli@gmail.com>
Message-ID: <CAK8P3a3zT0bh=itVjwWTEJFwoBxeQgpRZWJRhg8=Rk9-iyE04g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 7, 2017 at 6:58 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> ARCH_BRCMSTB was one of the few platforms that were not enabled by
> default, since we are now adding more and more drivers relevant to that
> platform get some proper build coverage.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> I can submit this through the next arm-soc pull requests (shortly), if
> that's okay with all of you, thanks!

Acked-by: Arnd Bergmann <arnd@arndb.de>
