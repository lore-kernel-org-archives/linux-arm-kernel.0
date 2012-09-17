From: olof@lixom.net (Olof Johansson)
Date: Sun, 16 Sep 2012 19:13:09 -0700
Subject: [GIT PULL 08/10] ARM: tegra: second round of cleanups
In-Reply-To: <1347653181-19936-8-git-send-email-swarren@wwwdotorg.org>
References: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
 <1347653181-19936-8-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120917021309.GN19186@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 02:06:19PM -0600, Stephen Warren wrote:
> This branch mainly removes dead code following the removal of all board
> files. The removals depend on various changes in other branches, so they
> are all merged together and form the basis of this branch, as enumerated
> below.
> 
> Finally, there are no remaining users of pinconf-tegra.h outside the
> pinctrl subsystem, so that header is incorporated into an existing file
> there. This reduces the number of headers in mach-tegra/include, and so
> helps move towards single zImage.
> 
> This branch is based on tegra-for-3.7-cleanup, followed by a merge of
> tegra-for-3.7-board-removal, followed by a merge of
> tegra-for-3.7-common-clk, followed by a merge of:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv-for-v3.7
> 
> ----------------------------------------------------------------
> 
> The following changes since commit fef40b2369a4ececa16b4d02b625e45252fe5d0a:
> 
>   Merge commit 'xceiv-for-v3.7' into for-3.7/cleanup2
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.7-cleanup2

Hi,

Nothing wrong with this branch, but I'm holding off until I get a strong
handshake from Felipe that his branch will not be rebased (sent off-list).


-Olof
