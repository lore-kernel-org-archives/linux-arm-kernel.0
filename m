From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Feb 2013 02:20:05 +0100
Subject: [PATCH 06/14] ARM: pci: Keep pci_common_init() around after init
In-Reply-To: <CACRpkdYGgdMTi0ZeMeCk5UmrndD451Pyz8L_XE=y9SPXfGGdew@mail.gmail.com>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <9348609.HjKCmL9u9S@wuerfel>
 <CACRpkdYGgdMTi0ZeMeCk5UmrndD451Pyz8L_XE=y9SPXfGGdew@mail.gmail.com>
Message-ID: <2957343.pp7RNnqk54@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 February 2013 18:07:53 Linus Walleij wrote:
> However it leaves the question of how much __init, __initdata
> and __initconst we have littering around. Oh, well, we'll see
> I guess.

Actually, kbuild is pretty good at warning around the
bugs there.

	Arnd
