From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 01 Dec 2014 10:43:16 +0100
Subject: [GIT PULL] Reset controller changes for v3.19
In-Reply-To: <1417424646.4624.2.camel@pengutronix.de>
References: <1417424646.4624.2.camel@pengutronix.de>
Message-ID: <1417426996.4624.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 01.12.2014, 10:04 +0100 schrieb Philipp Zabel:
> Hi Arnd, Olof,
> 
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/pza/linux.git reset-for-3.19-2

Sorry, that should be

   git://git.pengutronix.de/git/pza/linux.git reset-for-3.19-2
                            ^^^^

regards
Philipp

> for you to fetch changes up to f200890f224d9ed0af207145a2279f51c6be230b:
> 
>   reset: add socfpga_reset_status (2014-11-04 12:40:16 +0100)
> 
> ----------------------------------------------------------------
> Reset controller changes for v3.19
> 
> ----------------------------------------------------------------
> Dinh Nguyen (2):
>       reset: add reset_control_status helper function
>       reset: add socfpga_reset_status
> 
> Maxime Coquelin (1):
>       reset: stih407: Add reset controllers DT bindings
> 
> Peter Griffin (2):
>       reset: stih407: Add softreset, powerdown and picophy controllers
>       reset: sti: Document sti-picophyreset controllers bindings.
> 
> Philipp Zabel (1):
>       Merge tag 'sti-reset-for-v3.19-1' of git://git.stlinux.com/devel/kernel/linux-sti into reset/for_v3.19
> 
>  .../bindings/reset/st,sti-picophyreset.txt         |  42 ++++++
>  drivers/reset/core.c                               |  15 ++
>  drivers/reset/reset-socfpga.c                      |  15 ++
>  drivers/reset/sti/Kconfig                          |   4 +
>  drivers/reset/sti/Makefile                         |   1 +
>  drivers/reset/sti/reset-stih407.c                  | 158 +++++++++++++++++++++
>  .../dt-bindings/reset-controller/stih407-resets.h  |  61 ++++++++
>  include/linux/reset-controller.h                   |   2 +
>  include/linux/reset.h                              |   7 +
>  9 files changed, 305 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt
>  create mode 100644 drivers/reset/sti/reset-stih407.c
>  create mode 100644 include/dt-bindings/reset-controller/stih407-resets.h
> 
> 
