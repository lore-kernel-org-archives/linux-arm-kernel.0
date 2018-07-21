From: olof@lixom.net (Olof Johansson)
Date: Sat, 21 Jul 2018 15:05:29 -0700
Subject: [GIT PULL 1/6] i.MX drivers updates for 4.19
In-Reply-To: <1532140344-2771-1-git-send-email-shawnguo@kernel.org>
References: <1532140344-2771-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20180721220529.mafkyyw2y2dwtt5k@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2018 at 10:32:19AM +0800, Shawn Guo wrote:
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-drivers-4.19
> 
> for you to fetch changes up to 69c04aee3482415cff52061a3ccad4943662e81d:
> 
>   soc: imx6qp: Use GENPD_FLAG_ALWAYS_ON for PU errata (2018-07-17 14:12:14 +0800)
> 
> ----------------------------------------------------------------
> i.MX drivers update for 4.19:
>  - Handle i.MX6SL chip errata ERR006287 in the safest possible way by
>    keeping the DISP domain always-on, because Upon resuming from power
>    gating, the modules in the display power domain (eLCDIF, EPDC, PXP
>    and SPDC) might fail to perform register reads correctly.
>  - Use GENPD_FLAG_ALWAYS_ON flag for i.MX6QP PU ERR009619 handling.
>    It is functionally identical to the exsiting implementation but
>    simpler and slightly faster.

Merged, thanks!


-Olof
