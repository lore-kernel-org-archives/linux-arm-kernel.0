From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 13:15:04 +0200
Subject: [PATCH 2/3] ARM: CSR: mapping early DEBUG_LL uart
In-Reply-To: <1309945678-18813-3-git-send-email-bs14@csr.com>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<1309945678-18813-3-git-send-email-bs14@csr.com>
Message-ID: <201107061315.04342.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011, Barry Song wrote:
> Signed-off-by: Barry Song <bs14@csr.com>
> ---
>  arch/arm/mach-prima2/Makefile |    1 +
>  arch/arm/mach-prima2/lluart.c |   25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-prima2/lluart.c

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
