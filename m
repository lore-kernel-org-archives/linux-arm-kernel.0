From: cjb@laptop.org (Chris Ball)
Date: Sun, 20 May 2012 23:45:08 -0400
Subject: [PATCH] mmc: mxs-mmc: Add wp-inverted property
In-Reply-To: <1337571366-7779-1-git-send-email-marex@denx.de> (Marek Vasut's
 message of "Mon, 21 May 2012 05:36:06 +0200")
References: <1337571366-7779-1-git-send-email-marex@denx.de>
Message-ID: <87396ukxiz.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Sun, May 20 2012, Marek Vasut wrote:
> The write-protect GPIO is inverted on some boards. Handle such case.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: linux-mmc at vger.kernel.org
> Cc: Chris Ball <cjb@laptop.org>
> ---
>  Documentation/devicetree/bindings/mmc/mxs-mmc.txt |    1 +
>  drivers/mmc/host/mxs-mmc.c                        |   11 ++++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> V2: Adjust the subject, Cc linux-mmc

Thanks, looks good.  Since this depends on patches that are going via
arm-soc, I'm going to wait until that's in Linus master before merging.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
