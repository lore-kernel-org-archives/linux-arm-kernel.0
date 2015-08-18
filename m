From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Aug 2015 13:30:42 -0700
Subject: [GIT PULL] Renesas ARM Based SoC CPG/MSTP Clock Driver Updates
 for v4.3
In-Reply-To: <cover.1439365731.git.horms+renesas@verge.net.au>
References: <cover.1439365731.git.horms+renesas@verge.net.au>
Message-ID: <20150818203042.GF4732@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 05:15:13PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC CPG/MSTP clock driver updates
> for v4.3.
> 
> As requested by Olof, this is a repost of patches broken out of a now
> defunct pull-request, "Renesas ARM Based SoC CPG MSTP Clock Domain Updates
> for v4.3".  The motivation being to have driver changes in a separate
> branch to DT changes.
> 
> * These patches were Acked by Stephen Boyd in a reply to:
>   [PATCH v2 00/14] ARM: shmobile: Add CPG Clock Domains
>   https://lkml.org/lkml/2015/6/8/622
> * The patch subjects were subsequently updated with other changes in:
>   [PATCH v3 00/16] ARM: shmobile: Add CPG/MSTP Clock Domain
>   https://lkml.org/lkml/2015/7/1/408
> * And further updates were made in the patchset I queued up:
>   [PATCH v4 00/16] ARM: shmobile: Add CPG/MSTP Clock Domain
>   https://lkml.org/lkml/2015/8/4/389
> 
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clk-for-v4.3
> 
> for you to fetch changes up to f04b486d34ac6bab2aaa3988ee098b2bad3950de:
> 
>   clk: shmobile: rz: Add CPG/MSTP Clock Domain support (2015-08-12 10:31:28 +0900)

Merged into next/drivers.


-Olof
