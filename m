From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Apr 2012 10:59:33 -0700
Subject: [PATCH 06/11] ARM: tegra: seaboard: Don't gpio_request()
 ISL29018_IRQ
In-Reply-To: <1333148404-17691-7-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
 <1333148404-17691-7-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120404175933.GF29919@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 04:59:59PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Don't call gpio_request() or gpio_direction_input() for ISL29018_IRQ.
> This pin is only used as an IRQ, and hence no GPIO configuration should
> be necessary; the GPIO/IRQ driver should (and does) perform any required
> setup when the IRQ is requested.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Olof Johansson <olof@lixom.net>
