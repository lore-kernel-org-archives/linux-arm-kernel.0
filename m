From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 13:49:47 +0100
Subject: [PATCH v2] soc: mediatek: SCPSYS: use builtin_platform_driver
In-Reply-To: <1451464240-5313-1-git-send-email-matthias.bgg@gmail.com>
References: <1451464240-5313-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <4706196.Cy4tLmOZhy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 December 2015 09:30:40 Matthias Brugger wrote:
> SCPSYS can't be built as module. Use builtin_platform_driver instead.
> For this probe must not be __init and the data accessed can't be
> __initconst. Remove this macros. To make the impact as small as possible,
> fold scp_domain_data into scp_domain via a pointer.
> 
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
