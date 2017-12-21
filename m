From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 21:04:05 +0100
Subject: [GIT PULL 2/3] arm64: dts: exynos: DTS for v4.16
In-Reply-To: <CAJKOXPfKXWAmWUb86YW3zP3iniCU_hnZuacW4HONvYbmi0uoag@mail.gmail.com>
References: <20171220173643.5840-1-krzk@kernel.org>
 <20171220173643.5840-4-krzk@kernel.org>
 <CAK8P3a2obLRFK8cZ3B1M1qCzDQq=-7ux4_Tu4kG+ksW6NCieYg@mail.gmail.com>
 <CAJKOXPfKXWAmWUb86YW3zP3iniCU_hnZuacW4HONvYbmi0uoag@mail.gmail.com>
Message-ID: <CAK8P3a3KBbHgGTEpm5hO6p9HOg7R_3gifA=Gie+Fi+w5fKXS+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 8:31 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Dec 21, 2017 at 5:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, Dec 20, 2017 at 6:36 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The Nexell series are similar to Exynos but this is different company
> so probably they would end up in different sub-arch. Only some IP
> blocks are similar to Exynos even though the datasheet has Samsung
> marks. I saw patches for U-Boot (I do not remember the author) so
> maybe soon something will happen on LKML.

Ok. When I looked at an old 32-bit 3.4 kernel tree, I could see no similarity
to Exynos, but it seems that there is now an active development tree for
a 64-bit 4.x kernel for the Samsung Artik board series, just no patches.

       Arnd
