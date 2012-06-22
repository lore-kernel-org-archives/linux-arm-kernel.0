From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Jun 2012 17:14:52 +0000
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <201206221653.31817.arnd@arndb.de>
References: <4FDA2DDA.1030704@wwwdotorg.org>
 <CAErSpo56=S2oQ0usYfH28T0178SQUBD=5jqmcKWCT6M5WUQF6g@mail.gmail.com>
 <201206221653.31817.arnd@arndb.de>
Message-ID: <201206221714.53172.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 June 2012, Arnd Bergmann wrote:
> The part that is specific to PCs is that they don't have PCI domains
> normally.

Scratch that, PCs have moved on beyond that long ago, I just wasn't
aware that they also do that now. That was only true before mmconfig.

	Arnd
