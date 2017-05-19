From: olof@lixom.net (Olof Johansson)
Date: Thu, 18 May 2017 23:56:38 -0700
Subject: [GIT PULL 2/2] Broadcom drivers changes for 4.12
In-Reply-To: <20170514033526.21260-2-f.fainelli@gmail.com>
References: <20170514033526.21260-1-f.fainelli@gmail.com>
 <20170514033526.21260-2-f.fainelli@gmail.com>
Message-ID: <20170519065638.GB9628@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 13, 2017 at 08:35:26PM -0700, Florian Fainelli wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.12/drivers-fixes
> 
> for you to fetch changes up to 31d848aa1d85530770f0bdf1b61a042335d340ad:
> 
>   soc: bcm: brcmstb: Correctly match 7435 SoC (2017-05-13 20:27:33 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom SoC drivers fixes for 4.12, please
> pull the following:
> 
> - Florian removes the duplicate compatible string matched by the
>   SUN_TOP_CTRL driver and instead uses the correct one for 7435

Thanks, merged.


-Olof
