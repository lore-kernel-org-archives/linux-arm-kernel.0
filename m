From: olof@lixom.net (Olof Johansson)
Date: Tue, 14 Jun 2016 10:30:58 -0700
Subject: [GIT PULL] Reset controller changes for v4.8, part 2
In-Reply-To: <1465826857.3553.50.camel@pengutronix.de>
References: <1465826857.3553.50.camel@pengutronix.de>
Message-ID: <20160614173058.GF9200@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 04:07:37PM +0200, Philipp Zabel wrote:
> Dear arm-soc maintainers,
> 
> Please consider merging this tag with a new driver for the Amlogic Meson
> reset controller. It should be fine for Kevin to also merge this into
> his for-next branch to resolve the dependency of meson dtsi files on the
> new dt-bindings headers.
> 
> regards
> Philipp
> 
> The following changes since commit 168d7c4e8bb25c076ed8be67fcca84f5dcd0b2c6:
> 
>   reset: Return -ENOTSUPP when not configured (2016-06-01 08:21:08 +0200)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.8-2
> 
> for you to fetch changes up to 79795e20a184ebabf4ae743d1506cc39783caa46:
> 
>   dt-bindings: reset: Add bindings for the Meson SoC Reset Controller (2016-06-01 08:21:12 +0200)
> 
> ----------------------------------------------------------------
> Reset controller changes for v4.8, part 2
> 
> - add Amlogic Meson SoC Reset Controller driver

Merged, thanks.


-Olof
