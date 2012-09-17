From: olof@lixom.net (Olof Johansson)
Date: Sun, 16 Sep 2012 19:10:18 -0700
Subject: [GIT PULL 02/10] ARM: tegra: first round of cleanup
In-Reply-To: <1347653181-19936-2-git-send-email-swarren@wwwdotorg.org>
References: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
 <1347653181-19936-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120917021018.GF19186@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 02:06:13PM -0600, Stephen Warren wrote:
> This branch contains a few early cleanups; consistent use of IO_ADDRESS,
> always selecting USE_OF since we're converting to device-tree-only this
> merge window, and removing includes of some header files as part of
> working towards single zImage.
> 
> This branch is based on v3.6-rc4.
> 
> ----------------------------------------------------------------
> 
> The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:
> 
>   Linux 3.6-rc4
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.7-cleanup

Pulled into next/cleanup. Thanks!


-Olof
