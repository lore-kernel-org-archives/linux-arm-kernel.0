From: olof@lixom.net (Olof Johansson)
Date: Wed, 14 Aug 2013 01:04:05 -0700
Subject: [GIT PULL 0/4] Renesas ARM based SoC defconfig updates for v3.12
In-Reply-To: <cover.1375842392.git.horms+renesas@verge.net.au>
References: <cover.1375842392.git.horms+renesas@verge.net.au>
Message-ID: <20130814080405.GF30577@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 01:23:55PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider these Renesas ARM based SoC defconfig updates for v3.12.
> 
> 
> In relation to adding a new defconfig I would like to note that Magnus and
> I are aware of your ongoing requests to reduce the number of shmobile
> defconfigs and that we are making progress on that front in two ways:
> 
> * Two boards, and their defconfigs were scheduled for removal in v3.11
>   and a further two boards and their defconfigs are scheduled for removal
>   in v3.12.
> 
>   For reference the boards are: ap5evb, bonito, ag5evm and kota2
> 
> * More importantly, we are making significant progress towards being
>   able to use multiplatform and thus consolidate most if not all
>   of the shmobile defconfigs into either a single shmobile defconfig
>   or a more generic ARM defconfig.
> 
>   The removal of the boards mentioned above helps this process
>   by removing the need to update as much code. In particular code
>   which we have limited or no access to hardware to test.
> 
>   The main remaining barrier here is common clocks which I current
>   expect to take a few more release cycles to get in order.
> 
> 
> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
> 
>   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v3.12

Pulled. Looking forward to the removals. :)


-Olof
