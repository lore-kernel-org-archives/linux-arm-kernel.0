From: olof@lixom.net (Olof Johansson)
Date: Wed, 6 Jul 2016 22:21:26 -0700
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Updates for v4.8
In-Reply-To: <cover.1467293089.git.horms+renesas@verge.net.au>
References: <cover.1467293089.git.horms+renesas@verge.net.au>
Message-ID: <20160707052126.GH32389@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 04:16:22PM +0200, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM based SoC updates for v4.8.
> 
> This pull request is based on a merge of:
> 
> * This pull request is based on the previous round of
>   such requests, tagged as renesas-soc-for-v4.8,
>   which you have already pulled.
> 
> * "Second Round of Renesas ARM Based SoC R-Car SYSC Updates for v4.8",
>   tagged as renesas-rcar-sysc2-for-v4.8,
>   which I have also sent a pull request for.
> 
>   This provides run-time dependencies for APMU patches in this series
>   and prevents a regression in the absence of complementary DT updates.
> 
> 
> The following changes since commit f0aa411de83c096e09cf46b9ea0d68a1eeab4863:
> 
>   Merge branch 'rcar-sysc-for-v4.8' into HEAD (2016-06-29 14:41:43 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v4.8
> 
> for you to fetch changes up to f89a51700d7ae0ef58956a8c8f0e2c68767bcdae:
> 
>   ARM: shmobile: r8a7791: Prioritize DT APMU support (2016-06-29 14:43:40 +0200)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM Based SoC Updates for v4.8
> 
> * Add DT support to the APMU driver and prioritise DT APMU support
> * Obtain extal frequency from DT
> * Add support for r8a7792

Merged, thanks.


-Olof
