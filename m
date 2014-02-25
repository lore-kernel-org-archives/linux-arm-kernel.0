From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Feb 2014 16:00:23 -0700
Subject: [PATCHv2 1/5] ARM: tegra: remove obsolete gpio entries
In-Reply-To: <1393330950-7283-2-git-send-email-heikki.krogerus@linux.intel.com>
References: <1393330950-7283-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1393330950-7283-2-git-send-email-heikki.krogerus@linux.intel.com>
Message-ID: <530D2087.1020407@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2014 05:22 AM, Heikki Krogerus wrote:
> After moving to description based gpio interface in
> rfkill-gpio, the gpio numbers are not used any more.

Acked-by: Stephen Warren <swarren@nvidia.com>

This shouldn't cause any conflicts since I really don't anticipate
changing board-paz00.c in this kernel cycle other than this patch.

If you want though, I can prepare a branch and signed tag in the Tegra
tree, containing this patch, and you can merge it. I'm fine either way.
