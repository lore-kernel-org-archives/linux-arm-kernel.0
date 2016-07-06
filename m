From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 6 Jul 2016 11:06:18 -0500
Subject: [PATCH 1/3] reset: socfpga: no need to store modrst_offset
In-Reply-To: <1467713872-4051-1-git-send-email-p.zabel@pengutronix.de>
References: <1467713872-4051-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <577D2C7A.2030204@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2016 05:17 AM, Philipp Zabel wrote:
> Since we can just add it to membase once, there is no need to store
> modrst_offset separately, and to repeat the addition with every access.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/reset-socfpga.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 

In case you want it:

Tested-by: Dinh Nguyen <dinguyen@opensource.altera.com>

Thanks,
Dinh
