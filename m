From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 02 Feb 2011 15:05:09 +0300
Subject: [PATCH v1 7/9] mfd: pruss CAN private data.
In-Reply-To: <1296571667-12049-8-git-send-email-subhasish@mistralsolutions.com>
References: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
	<1296571667-12049-8-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <4D494875.50002@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-02-2011 17:47, Subhasish Ghosh wrote:

> This patch adds the PRUSS CAN data.

> Signed-off-by: Subhasish Ghosh<subhasish@mistralsolutions.com>
[...]

> diff --git a/include/linux/mfd/pruss/da8xx_pru.h b/include/linux/mfd/pruss/da8xx_pru.h
> index 318dad8..2fa7ff5 100644
> --- a/include/linux/mfd/pruss/da8xx_pru.h
> +++ b/include/linux/mfd/pruss/da8xx_pru.h
> @@ -74,6 +74,10 @@ struct da8xx_pruss_devices {
>   	int (*setup)(void);
>   };
>
> +struct da8xx_pruss_can_data {
> +	u32 version;
> +};
> +

    This patch too should precede the patch 5/9 as it defines the stucture 
used there...

WBR, Sergei
