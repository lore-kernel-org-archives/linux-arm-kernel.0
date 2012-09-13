From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Sep 2012 23:22:32 -0700
Subject: [GIT PULL 1/2] imx device tree changes
In-Reply-To: <1347364968-27496-2-git-send-email-shawn.guo@linaro.org>
References: <1347364968-27496-1-git-send-email-shawn.guo@linaro.org>
 <1347364968-27496-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120913062232.GI24290@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 08:02:47PM +0800, Shawn Guo wrote:
> The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:
> 
>   Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.7
> 
> for you to fetch changes up to f8135a74df53ba7010a162dddd112b73ee5652e3:
> 
>   ARM: imx6q-sabrelite: Rename 'pinctrl_gpio_hog' (2012-09-11 16:27:00 +0800)
> 
> ----------------------------------------------------------------
> imx-dt-3.7
> 
> - All imx53 board files are removed by the equal device tree support
> - The efikamx board files are removed to ease device tree migration
> - Remove dummy pinctrl state by setting up pinctrl in device tree

Hooray for more board file removals!

I had to do a trivial conflict resolve, please double-check my merge
into next/dt.


Thanks,

-Olof
