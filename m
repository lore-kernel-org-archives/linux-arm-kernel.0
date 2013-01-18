From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 18 Jan 2013 09:53:45 -0700
Subject: [PATCH 1/1] ARM: Add API to detect SCU base address from CP15
In-Reply-To: <1358506755-13705-1-git-send-email-hdoyu@nvidia.com>
References: <1358506755-13705-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <50F97E19.8070607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2013 03:59 AM, Hiroshi Doyu wrote:
> Add API to detect SCU base address from CP15.

So this patch appears to be a dependency for the Tegra114 series from
Hiroshi. As such, I need to get it into the Tegra tree somehow.

What I'd like to propose is that I put this one patch in a topic branch
based on v3.8-rcN, send a pull request to arm-soc containing that
branch, and then merge the branch into the Tegra tree. This will allow
anyone else to use the patch in code destined for 3.9.

Or, if nobody else wants to use this function, I could just apply it
directly to the Tegra tree.

But either way, I'd need an ack from a core ARM maintainer in order to
apply this (well, v2 once it's posted).
