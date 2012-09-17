From: olof@lixom.net (Olof Johansson)
Date: Sun, 16 Sep 2012 19:12:07 -0700
Subject: [GIT PULL 07/10] ARM: tegra: device tree changes
In-Reply-To: <1347653181-19936-7-git-send-email-swarren@wwwdotorg.org>
References: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
 <1347653181-19936-7-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120917021207.GK19186@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 02:06:18PM -0600, Stephen Warren wrote:
> This branch adds two main features to Tegra boards, simply by amending
> device tree files: regulator support and the ability to turn off system
> power when executing "shutdown".
> 
> As part of these changes, the board file for Cardhu is split into two
> versions, since different revisions have different hardware in some
> areas, especially related to regulators.
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.7-dt

Pulled into next/dt.

-Olof
