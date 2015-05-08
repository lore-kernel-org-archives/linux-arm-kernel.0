From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Fri, 08 May 2015 11:27:29 +0300
Subject: [PATCH v3 01/11] coresight-etm4x: Adding CoreSight ETM4x driver
In-Reply-To: <1430926047-9125-2-git-send-email-mathieu.poirier@linaro.org>
References: <1430926047-9125-1-git-send-email-mathieu.poirier@linaro.org>
 <1430926047-9125-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1431073649.21307.12.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Mathieu, 

On Wed, 2015-05-06 at 09:27 -0600, Mathieu Poirier wrote:
> 
> +static struct amba_id etm4_ids[] = {
> +       {       /* ETM 4.0 - Juno board */
> +               .id     = 0x000bb95e,
> +               .mask   = 0x000fffff,
> +               .data   = "ETM 4.0",
> +       },
> +       { 0, 0},
> +};
> +
> 

Any particular reason to remove device ID for the 
Hi6220 board? It happens to be the same ID used in
Qualcomm 8x16 ETM components. 

Regards,
Ivan
