From: olof@lixom.net (Olof Johansson)
Date: Sat, 21 Jul 2018 14:20:24 -0700
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Updates for v4.19
In-Reply-To: <cover.1532087129.git.horms+renesas@verge.net.au>
References: <cover.1532087129.git.horms+renesas@verge.net.au>
Message-ID: <20180721212024.466rmmvqlg2zvfew@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 02:05:30PM +0200, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM based SoC updates for v4.19.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-arm-soc-for-v4.19,
> which I have already sent a pull-request for.
> 
> 
> The following changes since commit c44e182e537492baaa37303fc0ee299222fce921:
> 
>   ARM: shmobile: convert to SPDX identifier (2018-06-18 12:00:29 +0200)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-soc2-for-v4.19
> 
> for you to fetch changes up to 54f464e0c91f10212fa5699bfef1f104ee7d2213:
> 
>   ARM: shmobile: Always enable ARCH_TIMER on SoCs with A7 and/or A15 (2018-07-20 13:44:10 +0200)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM Based SoC Updates for v4.19
> 
> * Always enable ARCH_TIMER on SoCs with A7 or A15
> 
>   All such SoCs have ARCH_TIMER so there is no need for it to be optional.
>   This allows clean-up which is included in this change.
> 
> * Do not compile r8a7779_platform_cpu_kill when it is unused
> 
>   This avoids a warning by shuffling code into an existing #ifdef
>   r8a7779 is the R-Car H1 SoC
> 
> * Add SMP enabler driver for the RZ/N1D (r9a06g032) SoC
> 
>   This is to allow SMP to be enabled via DT on the r9a06g032
> 
> * Stop compiling headsmp-apmu for non-SMP configs
> 
>   This is a minor clean-up allowing removal of an #ifdef

Merged, thanks! Nice tag description.


-Olof
