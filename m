From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 May 2016 14:07:57 +0200
Subject: [GIT PULL] Ux500 defconfig updates for v4.7
In-Reply-To: <CACRpkdaf39+gQzBb5U9gM5n17QwsNd7FxTbd3J+hLcuBNczKWA@mail.gmail.com>
References: <CACRpkdaf39+gQzBb5U9gM5n17QwsNd7FxTbd3J+hLcuBNczKWA@mail.gmail.com>
Message-ID: <24266746.WXjeqcnmtv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 May 2016 10:49:06 Linus Walleij wrote:
> Ux500 defconfig update for v4.7:
> - Remove the unused MACH_UX500_DT option from the multi_v7 defconfig
> - Remove staging driver from u8500_defconfig
> - Update sensor support in u8500_defconfig
> 

I was going to pull this today but noticed that this involves a backmerge
of v4.6-rc6. Can you rebase this on 4.6-rc3 or earlier to avoid the backmerge?

	Arnd
