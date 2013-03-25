From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Mar 2013 17:59:28 +0000
Subject: [PATCH] ARM64: early_printk: Fix check for CONFIG_ARM64_64K_PAGES
In-Reply-To: <1363988871.3728.46.camel@deadeye.wl.decadent.org.uk>
References: <1363988871.3728.46.camel@deadeye.wl.decadent.org.uk>
Message-ID: <20130325175928.GF3894@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 09:47:51PM +0000, Ben Hutchings wrote:
> The 'CONFIG_' prefix is not implicit in IS_ENABLED().
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Paul Bolle <pebolle@tiscali.nl>

Thanks. I'll push it upstream.

-- 
Catalin
