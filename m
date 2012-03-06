From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 6 Mar 2012 10:50:27 +0800
Subject: [PATCH v8 2/2] Regulator: Add Anatop regulator driver
In-Reply-To: <1330960049-28170-2-git-send-email-paul.liu@linaro.org>
References: <1330960049-28170-1-git-send-email-paul.liu@linaro.org>
 <1330960049-28170-2-git-send-email-paul.liu@linaro.org>
Message-ID: <20120306025025.GL16232@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 11:07:28PM +0800, Ying-Chun Liu (PaulLiu) wrote:
...
> +MODULE_AUTHOR("Nancy Chen <Nancy.Chen@freescale.com>");
> +MODULE_AUTHOR("Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>");

I meant something like:

MODULE_AUTHOR("Nancy Chen <Nancy.Chen@freescale.com>, "
	      "Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>");

Otherwise:

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> +MODULE_DESCRIPTION("ANATOP Regulator driver");
> +MODULE_LICENSE("GPL v2");

-- 
Regards,
Shawn
