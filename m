From: olof@lixom.net (Olof Johansson)
Date: Sun, 26 Feb 2012 14:25:23 -0800
Subject: [PATCH] ARM: tegra: select required CPU and L2 errata options
In-Reply-To: <1329251979-14805-1-git-send-email-swarren@nvidia.com>
References: <1329251979-14805-1-git-send-email-swarren@nvidia.com>
Message-ID: <20120226222523.GH11189@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2012 at 01:39:39PM -0700, Stephen Warren wrote:
> The ARM IP revisions in Tegra are:
> Tegra20: CPU r1p1, PL310 r2p0
> Tegra30: CPU A01=r2p7/>=A02=r2p9, NEON r2p3-50, PL310 r3p1-50
> 
> Based on work by Olof Johansson, although the actual list of errata is
> somewhat different here, since I added a bunch more and removed one PL310
> erratum that doesn't seem applicable.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Olof, should this be CC: stable?

Sounds reasonable. I've added the patch to for-3.4/cleanups_and_fixes and added
the cc. Given that it's not a refression I'm hesitant to send a fix for 3.3 at
this point in the release cycle.


-Olof
