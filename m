From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Mar 2014 10:39:42 -0600
Subject: [PATCH 1/4] pinctrl: tegra: fix some typos and inconsistencies
In-Reply-To: <1394220137-16351-1-git-send-email-swarren@wwwdotorg.org>
References: <1394220137-16351-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <531F3C4E.6040708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2014 12:22 PM, Stephen Warren wrote:
> drive_dev3_pins in pinctrl-tegra114.c wasn't used; delete it.
> 
> pinctrl-tegra124.c had quite a few typos. Fix those.
> 
> pinctrl-tegra124.c had a few mismatches between the *_groups[] ararys
> and the function lists in tegra124_groups[]. Fix those.

Oops. I appear to have sent this first patch separately a couple days
earlier and accidentally included another identical copy of it in this
series. This series should have only included patches 2..4.
