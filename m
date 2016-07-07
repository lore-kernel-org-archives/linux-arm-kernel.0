From: olof@lixom.net (Olof Johansson)
Date: Wed, 6 Jul 2016 22:11:09 -0700
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for
 v4.8
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <20160707051109.GF32389@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 04:15:54PM +0200, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM based SoC DT updates for v4.8.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-dt-for-v4.8,
> which you have already pulled.
> 
> 
> The following changes since commit b6960f19676e19f37a5e5a8af059fdf3b435d2f4:
> 
>   ARM: dts: silk: Fix W=1 dtc warnings (2016-05-30 09:37:13 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.8
> 
> for you to fetch changes up to 8fd763c75c3ab8e72e5d7f0d4c53531e6ff76197:
> 
>   ARM: dts: r8a7792: add SMP support (2016-06-30 14:26:14 +0200)

This one also introduces header files but I don't see any dependent driver
changes posted so far, so I'm going to presume that those changes will happen
after this is merged to avoid the cross-tree dependency.


Merged, thanks.


-Olof
