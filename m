From: olof@lixom.net (Olof Johansson)
Date: Thu, 6 Aug 2015 10:10:00 +0200
Subject: [GIT PULL v2] Renesas ARM Based SoC Marzen Board Removal for v4.3
In-Reply-To: <cover.1438581659.git.horms+renesas@verge.net.au>
References: <cover.1438581659.git.horms+renesas@verge.net.au>
Message-ID: <20150806081000.GA16520@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 03:04:55PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC marzen board removal for v4.3.
> 
> 
> This series removes legacy r8a7779 SoC and marzen board code.
> It aims to do do so in a way that does not introduce feature regressions
> when when booting the r8a7779/marzen board using shmobile_defconfig,
> which provides for booting using multiplatform, a scenario which previously
> used board code to provide some features including SMP.
> 
> Because of the above this series modifies SoC and DT files,
> and then removes code. And because of that it was not entirely clear to
> me which branch it should go into, so I have provided it in a stand-alone
> branch.
> 
> Unfortunately this branch has a number of minor conflicts with the "Renesas
> ARM Based SoC Cleanup for v4.3", tagged as renesas-cleanup-for-v4.3, which
> you have previously pulled.
> 
> A resolution to those conflicts can be found in the
> renesas-next-20150730-v4.2-rc1 tag of the renesas tree.
> 
> On a more positive note, I believe this to well over 8000 lines of legacy
> code removed in this cycle :)
> 
> 
> Changes between v1 and v2:
> 
> * As requested by Olof: Do not include defconfig updates;
>   these will be handled separately
> 
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-marzen-board-removal-for-v4.3

Merged, but it was a messy one and it's awkward to diff with your proposed
resolution due to other differences.

Please double-check that I resolved things correctly. Thanks!


-Olof
