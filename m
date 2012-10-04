From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 4 Oct 2012 21:22:05 +0100
Subject: [GIT PULL] Disintegrate UAPI for arm64
In-Reply-To: <17350.1349380264@warthog.procyon.org.uk>
References: <17350.1349380264@warthog.procyon.org.uk>
Message-ID: <20121004202204.GA6256@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2012 at 08:51:04PM +0100, David Howells wrote:
> Can you merge the following branch into the arm64 tree please.
> 
> This is to complete part of the UAPI disintegration for which the preparatory
> patches were pulled recently.
> 
> Note that there are some fixup patches which are at the base of the branch
> aimed at you, plus all arches get the asm-generic branch merged in too.
> 
> The following changes since commit 612a9aab56a93533e76e3ad91642db7033e03b69:
> 
>   Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux (2012-10-03 23:29:23 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.infradead.org/users/dhowells/linux-headers.git disintegrate-arm64
> 
> for you to fetch changes up to ae4f6c65798014d5d7a88d03e58faba53c0a92e1:
> 
>   UAPI: (Scripted) Disintegrate arch/arm64/include/asm (2012-10-04 18:20:24 +0100)
...
>  arch/c6x/Makefile                               |   2 +
>  arch/c6x/include/asm/Kbuild                     |   1 +
>  arch/c6x/include/asm/signal.h                   |  17 -
>  arch/c6x/include/asm/unistd.h                   |   4 -
>  arch/hexagon/include/asm/unistd.h               |   5 -
>  arch/openrisc/include/asm/unistd.h              |   5 -
>  arch/score/include/asm/unistd.h                 |   5 -
>  arch/tile/include/asm/unistd.h                  |   5 -
>  arch/unicore32/include/asm/unistd.h             |   4 -

It seems that this branch contains more than just arm64 changes. Are
they going into mainline separately?

-- 
Catalin
