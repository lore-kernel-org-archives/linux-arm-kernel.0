From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 05 Sep 2014 08:10:34 -0700
Subject: [GIT PULL] omap fixes against v3.17-rc3
In-Reply-To: <20140904230737.GA7319@atomide.com> (Tony Lindgren's message of
 "Thu, 4 Sep 2014 16:07:37 -0700")
References: <20140904230737.GA7319@atomide.com>
Message-ID: <7hiol2yufp.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:
>
>   Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-against-v3.17-rc3
>
> for you to fetch changes up to c7cc9ba11f8c09a4d12af0fc4aa9f9b026cdd354:
>
>   ARM: dts: dra7-evm: Add vtt regulator support (2014-09-04 12:49:22 -0700)
>
> ----------------------------------------------------------------
> Few fixes for omaps mostly for various devices to get them working
> properly on the new am437x and dra7 hardware for several devices
> such as I2C, NAND, DDR3 and USB. There's also a clock fix for omap3.
>
> And also included are two minor cosmetic fixes that are not
> stictly fixes for the new hardware support added recently to
> downgrade a GPMC warning into a debug statement, and fix the
> confusing comments for dra7-evm spi1 mux.
>
> Note that these are all .dts changes except for a GPMC change.
>
> ----------------------------------------------------------------

Applied to fixes,

Kevin
