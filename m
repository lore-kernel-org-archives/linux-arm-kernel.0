From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 16:18:06 -0800
Subject: [GIT PULL] Reset controller changes for v4.10
In-Reply-To: <1479237815.2456.59.camel@pengutronix.de>
References: <1479237815.2456.59.camel@pengutronix.de>
Message-ID: <20161119001806.GM8882@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 08:23:35PM +0100, Philipp Zabel wrote:
> Dear arm-soc maintainers,
> 
> Please consider merging this tag which adds OX820 support, removes
> unused modular code and obsolete STiH41[56] support, and adds support
> for multiple devices sharing a pulsed reset, as long as their
> requirement is just being reset once, some time before use.
> 
> regards
> Philipp
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.10
> 
> for you to fetch changes up to 7da33a37b48f11ffcb4a718f29a3d4552423fea1:
> 
>   reset: allow using reset_control_reset with shared reset (2016-11-14 09:58:28 +0100)
> 
> ----------------------------------------------------------------
> Reset controller changes for v4.10
> 
> - remove obsolete STiH41[56] platform support
> - add Oxford Semiconductor OX820 support
> - add reset index include files for OX810SE and OX820
> - make drivers with boolean Kconfig options explicitly
>   non-modular
> - allow shared pulsed resets via reset_control_reset, which
>   in this case means that the reset must have been triggered
>   once, but possibly earlier, after the function returns, and
>   is never triggered again for the lifetime of the reset
>   control

Merged, thanks.


-Olof
