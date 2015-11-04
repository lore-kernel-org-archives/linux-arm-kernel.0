From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Nov 2015 23:41:01 +0100
Subject: [PATCH 1/4] ARM: dts: kirkwood: add Linksys EA4500
In-Reply-To: <00000150d49a7cf7-e97bf540-89ce-49bf-a25e-2d082acab273-000000@email.amazonses.com>
References: <00000150d49a7cf7-e97bf540-89ce-49bf-a25e-2d082acab273-000000@email.amazonses.com>
Message-ID: <3957044.Sz6eC5OsVr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 November 2015 22:25:05 Luka Perkov wrote:
> +/ {
> +	model = "Linksys EA4500";
> +	compatible = "linksys,ea4500", "marvell,kirkwood-88f6282", "marvell,kirkwood";

According to https://wikidevi.com/wiki/Linksys_EA4500 there are multiple versions
of this device, and at least EA4500v3 is completely incompatible with the version
in this patch. Should we add "linksys,ea4500v1" as a compatible string to identify
this better?

	Arnd
