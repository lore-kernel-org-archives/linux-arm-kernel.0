From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 6 Oct 2012 15:10:28 +0200
Subject: [PATCH 1/3] i2c: i2c-mux-gpio: Use devm_kzalloc instead of kzalloc
In-Reply-To: <1348758784-15245-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1348758784-15245-1-git-send-email-maxime.ripard@free-electrons.com>
 <1348758784-15245-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20121006151028.3c9fbd53@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Sep 2012 17:13:02 +0200, Maxime Ripard wrote:
> Use the devm_kzalloc managed function to stripdown the error and remove
> code.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Jean Delvare <khali@linux-fr.org>
> Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---
>  drivers/i2c/muxes/i2c-mux-gpio.c |   14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> (...)

Note: I ended up applying this patch (it's on its way to Linus already)
because it did conflict with another patch in my tree. So only patches
2/3 and 3/3 in this series are left for Wolfram to handle.

-- 
Jean Delvare
