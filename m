From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Apr 2012 10:58:55 -0700
Subject: [PATCH 05/11] gpio: tegra: configure pins during irq_set_type
In-Reply-To: <1333148404-17691-6-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
 <1333148404-17691-6-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120404175855.GE29919@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 04:59:58PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> When a Tegra GPIO is used as an IRQ, it should be enabled as a GPIO (so
> the pinmux module isn't driving it as an output) and configured as a GPIO
> input (so the GPIO module isn't driving it as an output). Set this up
> automatically whenever an IRQ is requested, so that users of IRQs don't
> need to do this.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Olof Johansson <olof@lixom.net>
