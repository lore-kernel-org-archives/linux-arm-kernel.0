From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 28 Jun 2012 11:39:21 -0600
Subject: [PATCH 0/6] Port Tegra to generic clk framework
In-Reply-To: <1340879846-12900-1-git-send-email-pgaikwad@nvidia.com>
References: <1340879846-12900-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <4FEC96C9.5040906@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2012 04:37 AM, Prashant Gaikwad wrote:
> This patch set ports Tegra clock code to generic clock framework.

I've looked at this a bit off-list before, and any issues I had with it
have been resolved already. I'll likely apply it to Tegra's for-next in
fairly short order unless anyone jumps in with objections to my doing
so. This will give it more wide-spread testing. We can always pull it
out again if any significant issues are found.
