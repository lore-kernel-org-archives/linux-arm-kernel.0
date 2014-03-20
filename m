From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Mar 2014 14:45:14 -0700
Subject: [PATCH] ARM: tegra: fix Dalmore pinctrl configuration
In-Reply-To: <1395246995-13972-1-git-send-email-swarren@wwwdotorg.org>
References: <1395246995-13972-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140320214514.GF6649@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 10:36:35AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Remove some entries from Dalmore's device tree that attempt to set some
> options which aren't supported for the drive_gma pin group.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This should be applied on top of wherever Tegra's for-3.15/dt branch
> was merged into arm-soc.

Applied.

-Olof
