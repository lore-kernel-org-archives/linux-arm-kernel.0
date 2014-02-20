From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Feb 2014 00:37:28 -0800
Subject: [GIT PULL 00/13] Renesas ARM Based SoC Updates for v3.15
In-Reply-To: <cover.1391666228.git.horms+renesas@verge.net.au>
References: <cover.1391666228.git.horms+renesas@verge.net.au>
Message-ID: <20140220083728.GI19089@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 03:21:05PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> please consider these Renesas ARM based SoC updates for v3.15.
> 
> This pull request is based on "Renesas CPG update for v3.15",
> tagged as renesas-cpg-for-v3.15, which I am also sending a pull request for
> today. The reason for the dependency is to provide driver support for
> the "Wait for status on selected MSTP clocks" patches in this pull-request.
> These are correctness fixes.
> 
> 
> The following changes since commit a028c6da34d434e35ba8322568c756ea97ff3c18:
> 
>   ARM: shmobile: wait for MSTP clock status to toggle, when enabling it (2014-02-04 10:22:39 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v3.15
> 
> for you to fetch changes up to 012a7069b5a10a0851584d71a1facdc40a972319:
> 
>   ARM: shmobile: r8a7790: Add PCI USB host clock support (2014-02-04 10:25:03 +0900)

I've merged this in, not doing a separate branch for the clk patches.

I've merged this in under next/drivers, since the clock tables that are changed
are hopefully finding their way into drivers/clk in the not too distant future.

Let me know if this will add complications w.r.t. merge dependencies and we can
bring this back into next/soc, but unless you also change clock code in later
soc branches, they can just be independent of this.


-Olof
