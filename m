From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 17 May 2013 17:55:24 -0600
Subject: [PATCH] ARM: tegra: fix memory size on Beaver
In-Reply-To: <1368474451-11176-1-git-send-email-swarren@wwwdotorg.org>
References: <1368474451-11176-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5196C36C.8020103@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2013 01:47 PM, Stephen Warren wrote:
> Tegra30's boot ROM masks the top 1MiB of RAM. Fix the memory node in
> Beaver's DT file to reflect this.

I have applied this to Tegra's for-3.11/dt branch.
