From: horms@verge.net.au (Simon Horman)
Date: Mon, 28 Jan 2013 09:21:58 +0900
Subject: [PATCH 01/19] ARM: shmobile: fix defconfig warning on CONFIG_USB
In-Reply-To: <1359153858-31992-2-git-send-email-arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-2-git-send-email-arnd@arndb.de>
Message-ID: <20130128002156.GB3423@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 10:44:00PM +0000, Arnd Bergmann wrote:
> A recent update to the marzen_defconfig introduced a
> duplicate CONFIG_USB=y line. This removes one of the
> two.
> 
> arch/arm/configs/marzen_defconfig:86:warning: override: reassigning to symbol USB


Acked-by: Simon Horman <horms+renesas@verge.net.au>
