From: olof@lixom.net (Olof Johansson)
Date: Sat, 21 Jul 2018 14:31:30 -0700
Subject: [GIT PULL] ARM: at91: DT for 4.19
In-Reply-To: <20180720081859.GA22228@piout.net>
References: <20180720081859.GA22228@piout.net>
Message-ID: <20180721213130.ec3wmahq5wgyx34v@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 10:18:59AM +0200, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> Here are the unusually large DT PR for AT91. It contains mainly new DTs.
> 
> There is a pm.c change that I'm including here so it is along with the
> corresponding DT changes.
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.19-dt
> 
> for you to fetch changes up to c8cbc1c20c29697e7335a5044fe6c60aa5c6e922:
> 
>   ARM: dts: at91: fix typos for SSC TD functions (2018-07-20 10:05:14 +0200)
> 
> ----------------------------------------------------------------
> AT91 DT for 4.19:
> 
>  - New boards from Laird: WB45N, WB50N, SOM60 modules and DVK, Gatwick
>  - fix the PMC compatibles
> 
> ----------------------------------------------------------------
> Alexandre Belloni (4):
>       dt-bindings: arm: remove PMC bindings
>       dt-bindings: clk: at91: Document all the PMC compatibles
>       ARM: at91: fix USB clock detection handling

I guess this patch should have gone in a soc branch?

Anyway, merged as-is, unlikely to cause conflicts.


-Olof
