From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 May 2014 14:11:28 -0700
Subject: [GIT PULL] Renesas ARM Based SoC Boards Updates for v3.16
In-Reply-To: <cover.1397774190.git.horms+renesas@verge.net.au>
References: <cover.1397774190.git.horms+renesas@verge.net.au>
Message-ID: <20140505211128.GA29245@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 07:44:53AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM Based SoC Boards Updates for v3.16.
> 
> 
> This pull request is based on
> 3984ba10dddc5a10 ("ARM: shmobile: r8a7791: Rename VSP1_SY clocks to VSP1_S").
> 
> That commit is part of the pull request
> "Renesas ARM Based SoC Clock Updates for v3.16",
> tagged as renesas-clock-for-v3.16, which I have previously sent.
> 
> I have not rebased this pull-request on top of renesas-clock-for-v3.16
> in order to avoid churn in linux-next.
> 
> The reason for basing this pull-request on clock updates is
> that many of its patches depend on shmobile_clk_workaround() which
> is added as part of the clock updates.
> 
> 
> The following changes since commit 58ea1d53ba93620ac50fef9d9720b2323971f243:
> 
>   ARM: shmobile: r8a7791: Rename VSP1_SY clocks to VSP1_S (2014-04-14 11:30:11 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-for-v3.16
> 
> for you to fetch changes up to a09b2f0ba170dc89a67d6c4c4f027b37a085dad9:
> 
>   ARM: shmobile: lager legacy: Enable Quad SPI transfers for the SPI FLASH (2014-04-15 08:13:22 +0900)

Merged, thanks.

-Olof
