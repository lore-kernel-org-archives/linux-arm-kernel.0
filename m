From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 May 2016 14:26:43 +0200
Subject: [PATCH] reset: oxnas: Use devm register API and get rid of
 platform remove
In-Reply-To: <1463746897-24813-1-git-send-email-narmstrong@baylibre.com>
References: <1463746897-24813-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <16785613.U51XVX7YG6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 May 2016 14:21:37 Neil Armstrong wrote:
> Use the brand new devm_reset_controller_register() API to get rid of
> the platform driver remove callback.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/reset/reset-oxnas.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> Hi Philip,
> 
> This patch is based on your reset/next tree after the new
> devm_reset_controller_register() was merged.
> 
> I hope it could be merged for 4.7.
> 
> 

It's too late for that now, as it looks like a cleanup patch that
can wait until 4.8. If the patch fixes a bug that prevents it from
working correctly, please clarify that in the changelog text.

	Arnd
