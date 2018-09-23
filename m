From: olof@lixom.net (Olof Johansson)
Date: Sun, 23 Sep 2018 06:28:34 -0700
Subject: [GIT PULL 3/3] Broadcom devicetree-arm64 changes for 4.20
In-Reply-To: <20180914235928.20551-3-f.fainelli@gmail.com>
References: <20180914235928.20551-1-f.fainelli@gmail.com>
 <20180914235928.20551-3-f.fainelli@gmail.com>
Message-ID: <20180923132834.py7mhe2ikjwjnoje@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2018 at 04:59:28PM -0700, Florian Fainelli wrote:
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.20/devicetree-arm64
> 
> for you to fetch changes up to 7cdbe45da1a189e744e6801aebb462ee47235580:
> 
>   arm64: dts: broadcom: Fix I2C and SPI bus warnings (2018-09-13 15:05:47 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM64-based SoCs Device Tree changes
> for 4.20, please pull the following:
> 
> - Stefan provides a reference to the Compute Module IO Board V3 such
>   that we can reference the arm counterpart and still build it for arm64
> 
> - Rob fixes I2C and SPI bus warnings which are going to show up with his
>   update to DTC scheduled for 4.20

Merged, thanks!


-Olof
