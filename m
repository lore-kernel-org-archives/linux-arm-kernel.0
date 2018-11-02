From: olof@lixom.net (Olof Johansson)
Date: Fri, 2 Nov 2018 11:32:46 -0700
Subject: [GIT PULL] sprd dts for kernel v4.20-rc1
In-Reply-To: <1539854253-4784-1-git-send-email-chunyan.zhang@unisoc.com>
References: <1539854253-4784-1-git-send-email-chunyan.zhang@unisoc.com>
Message-ID: <20181102183246.r5xxwsic2mxwihsi@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 05:17:33PM +0800, Chunyan Zhang wrote:
> Hi Arnd,
> 
> For 4.20-rc1 there's one patch only for sprd devicetree, please pull from my git tree:
> 
> https://github.com/lyrazhang/linux.git m-v4.19-rc1
> 
> Please let me know if there's some problem.
> 
> Thanks,
> Chunyan
> 
> ----------------------------------------------------------------
> 
> Suzuki K Poulose (1):
>   arm64: dts: sc9836/sc9860: Update coresight bindings for hardware
>     ports
> 
>  arch/arm64/boot/dts/sprd/sc9836.dtsi |  78 +++++++------
>  arch/arm64/boot/dts/sprd/sc9860.dtsi | 215 ++++++++++++++++++-----------------
>  2 files changed, 151 insertions(+), 142 deletions(-)

Hi,

This came in right before the merge window so it wasn't included since
it's more of a cleanup. Please resend it after -rc1 is out and we'll be
happy to queue it up for 4.21.

Also, when you do, please use "git request-pull" to generate your pull request.
That contains more information about the base, etc, and is generally how we
prefer to get pull requests. When you do, also use a signed tag instead of just
a branch head for the pull request. Let us know if you need help on usage of
that.


Thanks!

-Olof
