From: olof@lixom.net (Olof Johansson)
Date: Sat, 2 Dec 2017 17:01:15 -0800
Subject: [GIT PULL] ARM: uniphier: fixes for v4.15
In-Reply-To: <CAK7LNARMXg-3Xfz2Mxq47Suys4kPSWuPYKY1o8HkVRBd4fHfSA@mail.gmail.com>
References: <CAK7LNARMXg-3Xfz2Mxq47Suys4kPSWuPYKY1o8HkVRBd4fHfSA@mail.gmail.com>
Message-ID: <20171203010115.d2ozvhkrnuwqngpo@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 11:01:57PM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Here are some fixes of ARM UniPhier SoC family.
> There is a mistake in the IRQ number.  Otherwise, I wouldn't have done
> this early pull request.  One more trivial patch to avoid conflict.
> Also, MAINTAINERS update, which is always safe.
> Please pull!
> 
> 
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-fixes-v4.15
> 
> for you to fetch changes up to 0308cadcec379e510f498c48c34aafe582f1af88:
> 
>   MAINTAINERS: exclude other Socionext SoC DT files from ARM/UNIPHIER
> entry (2017-11-29 22:22:10 +0900)
> 
> ----------------------------------------------------------------
> UniPhier ARM SoC fixes for v4.15
> 
> - Fix IRQ number of PXs3 SoC
> - Remove redundant interrupt-parent properties
> - Fix arm64 DT path in MAINTAINERS

Merged, thanks.


-Olof
