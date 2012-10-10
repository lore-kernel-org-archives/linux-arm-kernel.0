From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Oct 2012 18:30:44 +0000
Subject: [PATCH 1/7] ARM: clps711x: convert to clockevents
In-Reply-To: <1349883933-8881-1-git-send-email-shc_work@mail.ru>
References: <1349883933-8881-1-git-send-email-shc_work@mail.ru>
Message-ID: <201210101830.44365.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 October 2012, Alexander Shiyan wrote:
> This patch converts CLPS711X-platform to use modern clockevent API.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/Kconfig                |    2 +-
>  arch/arm/mach-clps711x/common.c |   38 +++++++++++++++++---------------------
>  2 files changed, 18 insertions(+), 22 deletions(-)

Overall a very nice series, all 7 patches. I just have a few trivial
comments for patch 5.

	Arnd
