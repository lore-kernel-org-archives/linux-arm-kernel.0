From: olof@lixom.net (Olof Johansson)
Date: Wed, 1 Apr 2015 16:38:59 -0700
Subject: [GIT PULL] Renesas ARM Based SoC sh73a0 Multiplatform Updates
 for v4.1
In-Reply-To: <cover.1425518682.git.horms+renesas@verge.net.au>
References: <cover.1425518682.git.horms+renesas@verge.net.au>
Message-ID: <20150401233859.GC8137@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 10:58:26AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC sh73a0 multiplatform updates for v4.1.
> 
> This pull request is based on the previous round of
> such requests, tagged as sh73a0-multiplatform-for-v4.1.base,
> which I have already sent a pull-request for.
> 
> 
> This pull request is based on a merge of the following pull requests
> which you have already pulled:
> 
> * "Renesas ARM Based SoC Simple PM Bus Updates for v4.1",
>   tagged as renesas-simple-pm-bus-for-v4.1.
> 
> * "Renesas ARM Based SoC DT Updates for v4.1", tagged as renesas-dt-for-v4.1.
> 
> 
> This pull requests has a number of minor conflicts with "Renesas ARM Based
> SoC sh7372 SoC Removal Updates for v4.1", tagged as
> renesas-sh7372-soc-removal-for-v4.1, which you have already pulled.
> 
> The conflicts are in the following files:
>         arch/arm/boot/dts/Makefile
>         arch/arm/mach-shmobile/Makefile
>         arch/arm/mach-shmobile/Makefile.boot
>         arch/arm/mach-shmobile/include/mach/zboot.h

It'd be nice to keep the dts changes in your DT branch, so there's less risk
for add/remove conflicts. I don't think there will be any this release so it's
not a big deal, but keep it in mind in the future.

Also, as already mentioned, some of this could have gone in one larger joined
branch (and based on the cleanups to avoid conflicts).


-Olof
