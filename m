From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Jun 2016 12:21:36 -0700
Subject: [GIT PULL] Reset controller changes for v4.8
In-Reply-To: <1464799179.3522.62.camel@pengutronix.de>
References: <1464799179.3522.62.camel@pengutronix.de>
Message-ID: <20160603192136.GD3761@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 06:39:39PM +0200, Philipp Zabel wrote:
> Dear arm-soc maintainers,
> 
> This tag contains the devm_reset_controller_register call and a series
> of patches to make use of it, and a patch to fix all reset_control_get
> stubs to return -ENOTSUPP when reset control support is disabled, for
> consistency.
> 
> regards
> Philipp

Merged into next/drivers for 4.8. Thanks!

-Olof
