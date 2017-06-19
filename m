From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 23:06:19 -0700
Subject: [GIT PULL 2/5] i.MX SoC updates for 4.13
In-Reply-To: <1497801323-6389-2-git-send-email-shawnguo@kernel.org>
References: <1497801323-6389-1-git-send-email-shawnguo@kernel.org>
 <1497801323-6389-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20170619060619.GE13137@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 18, 2017 at 11:55:20PM +0800, Shawn Guo wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.13
> 
> for you to fetch changes up to bf5a01d7c50fb0c4e1c3d320d670bad252d50bcb:
> 
>   ARM: imx6ull: Make suspend/resume work like on 6ul (2017-06-07 11:38:40 +0800)
> 
> ----------------------------------------------------------------
> The i.MX SoC updates for 4.13:
>  - Select GPCv2 for i.MX7 SoCs to get imx-gpcv2 irqchip driver built
>    for i.MX7 platforms by default.
>  - A couple of patches from Leonard to add IMX6ULL cpu check and get
>    suspend/resume work on IMX6ULL.

Merged, thanks.


-Olof
