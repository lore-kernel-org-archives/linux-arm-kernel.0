From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Nov 2009 09:03:29 +0100
Subject: [PATCH v4] mx27: Add basic support for Maxtrack i-MXT TD60
In-Reply-To: <37367b3a0911250924u2224c484id539e8007abfed34@mail.gmail.com>
References: <37367b3a0911250924u2224c484id539e8007abfed34@mail.gmail.com>
Message-ID: <20091127080329.GH27548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 03:24:50PM -0200, Alan Carvalho de Assis wrote:
> Signed-off-by: Alan Carvalho de Assis <acassis@gmail.com>
> ---
>  arch/arm/mach-mx2/Kconfig                   |    7 +
>  arch/arm/mach-mx2/Makefile                  |    1 +
>  arch/arm/mach-mx2/mxt_td60.c                |  284 +++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/uncompress.h |    1 +
>  4 files changed, 293 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mx2/mxt_td60.c

Applied. Your mailer wraps lines. I fixed this manually, but please have
a look next time.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
