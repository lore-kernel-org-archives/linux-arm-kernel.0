From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Apr 2012 10:58:29 -0700
Subject: [PATCH 04/11] gpio: tegra: Iterate over the correct number of
 banks
In-Reply-To: <1333148404-17691-5-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
 <1333148404-17691-5-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120404175829.GD29919@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 04:59:57PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> When Tegra30 support was added to the Tegra GPIO driver, a few places
> which iterated over all banks were not converted to use the variable
> tegra_gpio_bank_count rather than hard-coding the bank count. Fix this.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Olof Johansson <olof@lixom.net>

Should this be fixed in 3.4 as well? Given the need for some of the other
patches in this series I suppose gpio isn't really working on tegra30 there
though, so it's not technically a regression...


-Olof
