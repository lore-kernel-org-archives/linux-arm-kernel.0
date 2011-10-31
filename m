From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 31 Oct 2011 02:31:52 +0200
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <4EAB1BFF.3070406@gmail.com>
References: <4EA5DADC.7030805@gmail.com> <4EAB1BFF.3070406@gmail.com>
Message-ID: <201110310131.53251.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 October 2011, Rob Herring wrote:
>   Merge branch 'for-sfr' of
> git://openlinux.windriver.com/people/paulg/linux-next into HEAD
> (2011-10-28 15:51:07 -0500)
> 

Rob, I think there is no chance that this is working out.

I've just spent a few hours trying to resolve all the dependencies from this,
but I don't think it will work out, unless Linus pulls that tree very soon,
which I think is very unlikely.

Have you made sure that Paul even considers this branch stable?

Normally this kind of change gets pushed *last* in the merge window, to make
it possible to fix up all the stuff that breaks. This means I cannot
wait for the branch to get merged upstream before send a pull request for
my next/dt and next/soc branches.

Do you even depend on that branch? It seems to me that you merely have a
conflict, not a dependency, so why do you even try fixing it up?

	Arnd
