From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Sep 2014 11:30:54 -0700
Subject: [GIT PULL 3/3] ARM: imx: device tree changes for 3.18
In-Reply-To: <20140916044940.GC25583@dragon>
References: <20140916044940.GC25583@dragon>
Message-ID: <20140924183054.GJ19284@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[Adding Lee so he knows we've merged in the dependency now]

On Tue, Sep 16, 2014 at 12:49:41PM +0800, Shawn Guo wrote:
> Hi arm-soc folks,
> 
> This is the i.MX device tree updates for 3.18.  Per request from MFD
> maintainer Lee Jones, the following tag was pull into my DT branch to
> to avoid potential conflicts.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-arm-v3.18

Excellent, thanks for the heads up. Added as depends/mfd-ib in our tree
so we've got it labelled as an external dependency.

> Besides of that, the pull request is also based on imx-soc-3.18 one for
> sake of dependency.
> 
> Please pull, thanks.
> 
> Shawn
> 
> The following changes since commit 155b2fd3d6862509ccb356ff20fff8115d36eedb:
> 
>   Merge branch 'imx/soc' into imx/dt (2014-09-16 10:24:58 +0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-3.18
> 
> for you to fetch changes up to 2b2244a3e7c3d537f436a3580999b3032628d17d:
> 
>   ARM: dts: imx6: make gpt per clock can be from OSC (2014-09-16 10:27:32 +0800)

Merged, thanks.


-Olof
