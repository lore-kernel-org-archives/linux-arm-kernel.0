From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Apr 2016 11:03:17 +0200
Subject: [GIT PULL] ARM: EXYNOS: fixes for v4.6
In-Reply-To: <1461738154-8335-1-git-send-email-k.kozlowski@samsung.com>
References: <1461738154-8335-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5647946.YabRqFapJm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2016 08:22:34 Krzysztof Kozlowski wrote:
>   ARM: EXYNOS: Properly skip unitialized parent clock in power domain on (2016-04-25 11:35:37 +0200)
> 
> ----------------------------------------------------------------
> Fix for more theoretical than practical OOPS on first turn on of a exynos
> power domain, if there was no turn off before. Usually all power domains
> are on, so the first action is to turn off but some older bootloaders
> might behave differently.
> 

Pulled into fixes. Linus has just merged a larger set of fixes from
arm-soc, and this one doesn't seem very urgent, so I'd wait for more
important fixes to come up before sending out another pull request.

In the unlikely case that we don't get any critical bugfixes, I'd just
send this one for 4.7.

	Arnd
