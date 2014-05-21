From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 May 2014 16:52:20 +0200
Subject: [Patch v4 0/5] Introduce keystone reset driver
In-Reply-To: <1400682454-24535-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1400682454-24535-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <8843733.6ZFJt7BN6L@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 May 2014 17:27:29 Ivan Khoronzhuk wrote:
> These patches introduce keystone reset driver.
> 
> The keystone SoC can be rebooted in several ways. By external reset
> pin, by soft and by watchdogs. This driver allows software reset and reset
> by one of the watchdogs. Also added opportunity to set soft/hard reset type.
> 
> Based on linux-next/master

Hi Ivan,

The code looks good to me now, but I have some comments about the
binding. Patches 1, 3 and 5

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the quick update.
