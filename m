From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 06 Jan 2014 13:52:39 -0700
Subject: [PATCH] ARM: tegra: Properly sort clocks property
In-Reply-To: <1389021642-5516-1-git-send-email-treding@nvidia.com>
References: <1389021642-5516-1-git-send-email-treding@nvidia.com>
Message-ID: <52CB1797.9050303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2014 08:20 AM, Thierry Reding wrote:
> Other files and nodes list the resets property after the clocks property
> so do the same here for consistency.

Since this is purely cosmetic, I'll apply it for 3.15.
