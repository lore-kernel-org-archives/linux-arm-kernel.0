From: briannorris@chromium.org (Brian Norris)
Date: Thu, 8 Sep 2016 11:05:34 -0700
Subject: [PATCH] phy: rockchip-typec: add pm_runtime_disable in err case
In-Reply-To: <1473356291-19247-1-git-send-email-zyw@rock-chips.com>
References: <1473356291-19247-1-git-send-email-zyw@rock-chips.com>
Message-ID: <20160908180533.GA29048@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 10:38:11AM -0700, Chris Zhong wrote:
> Add pm_runtime_disable in err case to make the pm_runtime_enable/disable
> is invoked balanced.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>

Makes sense.

Reviewed-by: Brian Norris <briannorris@chromium.org>
