From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Dec 2015 10:12:23 +0100
Subject: [PATCH v2 2/3] soc: dove: add legacy support to PMU driver
In-Reply-To: <E1a5j6Q-000879-GO@rmk-PC.arm.linux.org.uk>
References: <E1a5j6Q-000879-GO@rmk-PC.arm.linux.org.uk>
Message-ID: <3992773.OhGRJ7lcb6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 06 December 2015 23:52:26 Russell King wrote:
> Add support for legacy non-DT Dove to the PMU driver, so that we can
> transition the legacy support over.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> This is a re-post of a previous patch, except I've split it into two to
> make the eventual removal of legacy Dove easier, as I believe Arnd will
> have some patches which touch legacy Dove which will conflict.  This
> makes it possible to revert this when the legacy Dove code is removed.

Looks good, all three patches

Acked-by: Arnd Bergmann <arnd@arndb.de>
