From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 1 Mar 2013 11:43:14 +0200
Subject: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
In-Reply-To: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
References: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <20130301094314.GG23234@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 10:42:28AM +0100, Pali Roh?r wrote:
> Signed-off-by: Ivaylo Dimitrov <freemangordon@abv.bg>
> Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
> ---
>  arch/arm/mach-omap2/Makefile            |    1 +
>  arch/arm/mach-omap2/board-rx51-secure.c |   66 +++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/board-rx51-secure.h |   36 +++++++++++++++++
>  arch/arm/mach-omap2/board-rx51-smc.S    |   34 ++++++++++++++++
>  arch/arm/mach-omap2/board-rx51.c        |    7 ++++
>  5 files changed, 144 insertions(+)
>  create mode 100644 arch/arm/mach-omap2/board-rx51-secure.c
>  create mode 100644 arch/arm/mach-omap2/board-rx51-secure.h
>  create mode 100644 arch/arm/mach-omap2/board-rx51-smc.S
> 

Is this necessary? I thought the PPA sets this bit?

Cheers,

Peter.
