From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 7 Oct 2011 11:48:37 +0800
Subject: [PATCH 04/26] net/pxa168_eth: add missing include of interrupt.h
In-Reply-To: <1317499438-14058-5-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-5-git-send-email-arnd@arndb.de>
Message-ID: <CAMPhdO8jTemD+W8c+RqbhiaxBA1OSwcp1h4xbU7h1o__PH42zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 2, 2011 at 4:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> interrupt.h is no longer implicitly included here, so manually
> add it instead.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.

> ---
> ?drivers/net/pxa168_eth.c | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/net/pxa168_eth.c b/drivers/net/pxa168_eth.c
> index 1a3033d..d5a6cfc 100644
> --- a/drivers/net/pxa168_eth.c
> +++ b/drivers/net/pxa168_eth.c
> @@ -41,6 +41,7 @@
> ?#include <linux/phy.h>
> ?#include <linux/io.h>
> ?#include <linux/types.h>
> +#include <linux/interrupt.h>
> ?#include <asm/pgtable.h>
> ?#include <asm/system.h>
> ?#include <asm/cacheflush.h>
> --
> 1.7.5.4
>
>
