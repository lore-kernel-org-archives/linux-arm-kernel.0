From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 20 Aug 2012 23:00:17 +0300
Subject: [PATCH] drivers/watchdog: Adding PRCMU based WD for ux500
 processors
In-Reply-To: <1345492255-28900-1-git-send-email-mathieu.poirier@linaro.org>
References: <1345492255-28900-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20120820200017.GE3829@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On Mon, Aug 20, 2012 at 01:50:55PM -0600, mathieu.poirier at linaro.org wrote:
> From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>
> 
> This patch is a partial re-write of the driver developed by
> Jonas Aaberg and brings it up to the new watchdog interface
> now the standard in the mainline kernel.
> 
> Cc: Jonas Aaberg <jonas.aberg@stericsson.com>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

[snip]

> +/**
> + * struct ux500_wdt_data
> + */
> +struct ux500_wdt_data {
> +	int timeout;
> +	int nowayout;
> +};

This struct doesn't seem to be used anywhere.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
