From: olof@lixom.net (Olof Johansson)
Date: Sun, 23 Sep 2018 05:32:57 -0700
Subject: [GIT PULL] Allwinner fixes for v4.19 - Round 2
In-Reply-To: <20180920042453.GA18194@wens.csie.org>
References: <20180920042453.GA18194@wens.csie.org>
Message-ID: <20180923123257.kk5g5xd2tjbsurfj@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 12:24:53PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> This is a second fixes pull request for arm-soc, based on the first pull
> request I sent earlier.
> 
> Also, I seem to remember seeing on ksummit-discuss that single patch PRs
> are a bit annoying. Would the maintainers prefer we just resend single
> patches instead? I'm not sure how that would work out if we later had
> to base -next material on it, but I guess we could base it off a -fixes
> branch in arm-soc.

Either base it off of our fixes branch, or if the fix goes into an early -rc
you can also based it off of that (but we try to avoid moving forward onto
later rcs if we can).

Single patch pull requests are OK as well. Whatever fits your workflow the
best, but if sending patches works, feel free to.

> The following changes since commit d177c8b61d6b4ef360b1c2682e4d8e3bae01738b:
> 
>   arm64: allwinner: dts: h6: fix Pine H64 MMC bus width (2018-08-27 09:21:00 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-fixes-for-4.19-2

Merged, thanks.


-Olof
