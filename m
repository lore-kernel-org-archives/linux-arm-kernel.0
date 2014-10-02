From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Oct 2014 16:46:39 +0200
Subject: [GIT PULL] RealView device tree support
In-Reply-To: <CACRpkdbVtkme_CYrmF7ymsMGP3OO9mr_DPALRUeWGQh35-Uf=g@mail.gmail.com>
References: <CACRpkdbVtkme_CYrmF7ymsMGP3OO9mr_DPALRUeWGQh35-Uf=g@mail.gmail.com>
Message-ID: <3204791.dOjkWKTCre@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 October 2014 09:38:17 Linus Walleij wrote:
> A bit late maybe, so no biggie if this does not hit the merge
> window.
> 
> However the dependent driver changes are already pending,
> and this is pretty isolated. Now the device tree support is
> split in two patches as requested.

You know I was really looking forward to this one, but I find
it hard to justify merging it now and not merging some of the
other parts I've started rejecting.

I've also twice been bitten now by 'just DT changes' that ended
up breaking the build, so I'd rather err on the side of being too
cautious now until the merge window.

	Arnd
