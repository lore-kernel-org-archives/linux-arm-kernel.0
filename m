From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Sep 2014 11:28:15 -0700
Subject: [GIT PULL 2/3] ARM: imx: SoC updates for 3.18
In-Reply-To: <20140916044758.GB25583@dragon>
References: <20140916044758.GB25583@dragon>
Message-ID: <20140924182815.GI19284@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 12:47:59PM +0800, Shawn Guo wrote:
> Hi arm-soc folks,
> 
> This is the i.MX SoC changes for 3.18.  It's based on imx-cleanup-3.18
> pull request for dependency reason.
> 
> Please pull, thanks.
> 
> Shawn
> 
> The following changes since commit 64d14a31d5410ea34641c41795e0ba222bda740c:
> 
>   ARM: imx: Remove mach-mxt_td60 board file (2014-09-10 11:17:44 +0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-3.18
> 
> for you to fetch changes up to 64546e9fe3a5b8cf62c946521c71d0532d399850:
> 
>   ARM: imx_v6_v7_defconfig updates (2014-09-16 10:09:43 +0800)
> 
> ----------------------------------------------------------------
> The i.MX SoC updates for 3.18:
>  - Add initial devicetree support for i.MX1
>  - Support GPT per clock source from OSC for i.MX6
>  - A couple of parent selection corrections for i.MX6SL clock driver
>  - Support more chip revision for i.MX6
>  - Convert pr_warning to pr_warn
>  - Add exclusive gate clock support
>  - Add BYPASS support for i.MX6 PLL clocks
>  - Update i.MX6 clock tree for audio use case
>  - A couple of VF610 clock driver updates

Merged, thanks.


-Olof
