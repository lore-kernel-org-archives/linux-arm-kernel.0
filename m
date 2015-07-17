From: olof@lixom.net (Olof Johansson)
Date: Fri, 17 Jul 2015 10:22:54 -0700
Subject: [GIT PULL] EP93xx cleanups for v4.3
In-Reply-To: <CACRpkdbEnK2Z2SW-QafisHv9hXv-bSdYx0dS7wtGh3oMDDcg=A@mail.gmail.com>
References: <CACRpkdbEnK2Z2SW-QafisHv9hXv-bSdYx0dS7wtGh3oMDDcg=A@mail.gmail.com>
Message-ID: <20150717172254.GJ21691@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 02:11:15PM +0200, Linus Walleij wrote:
> Hi ARM SoC people,
> 
> this is a long due pull request finally doing some EP93xx
> cleanups, most prominently:
> 
> - Switch to GENERIC TIME
> 
> - Remove memory config options and rely on PATCH_PHYS_VIRT
> 
> I forgot the latter in the tag text, feel free to copy it
> back in when pulling.

Done.

> 
> There is a series of defconfig changes adjacent to this that
> I would consider merging into the same branch on top
> of this, but I don't know how you want to handle it so they
> will be served separately.

Will either set be usable on its own, or do they need to go in together?

If it's the latter then they should be on top of each other. Anyway, I've
merged both of them now so at least for-next will have it all.

> Please pull this in for v4.3!

Merged, thanks!


-Olof
