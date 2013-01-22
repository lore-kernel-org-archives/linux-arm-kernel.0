From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jan 2013 08:27:54 +0000
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <20130121224449.GZ23505@n2100.arm.linux.org.uk>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
 <50FDBEAC.2050606@linaro.org> <20130121224449.GZ23505@n2100.arm.linux.org.uk>
Message-ID: <201301220827.55209.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 January 2013, Russell King - ARM Linux wrote:
> In this particular case, EBSA110 is not a candidate for multi-arch
> build anyway, because it's ARMv4 and we're only really bothering with
> ARMv6 and better.
> 
> Not only that, but the IO stuff on it is sufficiently obscure and
> non-standard...

Right, no point worrying about EBSA110. We need to work out OMAP and
Exynos/S5P though: As long as OMAP needs 128HZ and Exynos needs 200HZ,
we can never have them in the same kernel.

	Arnd
