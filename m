From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 14:29:39 -0800
Subject: [GIT PULL] Reset controller changes for v4.11
In-Reply-To: <1484933170.2897.76.camel@pengutronix.de>
References: <1484933170.2897.76.camel@pengutronix.de>
Message-ID: <20170129222939.GA3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 06:26:10PM +0100, Philipp Zabel wrote:
> Dear arm-soc maintainers,
> 
> Please consider merging this tag which adds reset controller drivers for
> Hi3660 and ZX2967 SoCs and adds SD reset support for LD11 SoCs. It makes
> the API describe optional and not present reset controls as NULL
> pointers, which will allow some drivers to simplify their return value
> handling. There also is a ti_syscon status return value fix, a typo fix,
> and some constification.
> 
> regards
> Philipp
> 
> The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:
> 
>   Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/pza/linux tags/reset-for-4.11
> 
> for you to fetch changes up to bb475230b8e59a547ab66ac3b02572df21a580e9:
> 
>   reset: make optional functions really optional (2017-01-20 10:36:15 +0100)
> 
> ----------------------------------------------------------------
> Reset controller changes for v4.11
> 
> - fix ti_syscon reset_status reporting
> - add Hisilicon Hi3660 reset controller driver
> - add ZTE ZX2967 reset controller driver
> - add LD11 SD-reset block to uniphier reset controller driver
> - typo and correctness fixes
> - make reset_control_get variants return NULL instead of an
>   error for optional, not specified resets and have the other
>   reset API functions silently ignore rstc == NULL parameters.

Merged, thanks.

-Olof
