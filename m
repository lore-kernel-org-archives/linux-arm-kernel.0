From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 16 Feb 2015 21:20:47 +0530
Subject: [PATCH 05/11] ARM: davinci: multi-soc kernels require
 AUTO_ZRELADDR
In-Reply-To: <1423770163-583064-6-git-send-email-arnd@arndb.de>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
 <1423770163-583064-6-git-send-email-arnd@arndb.de>
Message-ID: <54E211D7.1040208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 February 2015 01:12 AM, Arnd Bergmann wrote:
> The davinci DA8xx and DMx families have incompatible zreladdr
> settings, and attempting to build a kernel with both enabled
> results in an error unless AUTO_ZRELADDR is set:
> 
> multiple zreladdrs: 0xc0008000 0x80008000
> This needs CONFIG_AUTO_ZRELADDR to be set
> 
> This patch changes Kconfig to make the two families mutually
> exclusive when this is unset.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks for the fixes, Arnd!

Regards,
Sekhar
