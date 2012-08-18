From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 18 Aug 2012 18:08:21 +0000
Subject: [PATCH 01/11] ARM: defconfig: Remove CONFIG_MISC_DEVICES
In-Reply-To: <1345307035-3545-1-git-send-email-festevam@gmail.com>
References: <1345307035-3545-1-git-send-email-festevam@gmail.com>
Message-ID: <201208181808.21484.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 18 August 2012, Fabio Estevam wrote:
> 
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> commit 7c5763 (drivers:misc: Remove MISC_DEVICES config option) removed 
> CONFIG_MISC_DEVICES option, so remove the occurrences from the config files 
> as well.
> 
> Cc: <linux-arm-kernel@lists.infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
