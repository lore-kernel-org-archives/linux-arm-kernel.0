From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Nov 2012 15:53:19 +0000
Subject: [PATCH 2/4] ARM: sunxi: Add earlyprintk support for UART0 (sun4i)
In-Reply-To: <1353323383-11827-2-git-send-email-sr@denx.de>
References: <1353323383-11827-1-git-send-email-sr@denx.de>
 <1353323383-11827-2-git-send-email-sr@denx.de>
Message-ID: <201211191553.19166.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 November 2012, Stefan Roese wrote:
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig.debug         | 9 ++++++++-
>  arch/arm/include/debug/sunxi.S | 5 ++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>
