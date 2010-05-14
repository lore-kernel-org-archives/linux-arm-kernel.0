From: h-kanigeri2@ti.com (Kanigeri, Hari)
Date: Fri, 14 May 2010 16:27:22 -0500
Subject: [PATCH v2 08/17] omap: mailbox: only compile for configured archs
In-Reply-To: <1273849310-32169-9-git-send-email-felipe.contreras@gmail.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
	<1273849310-32169-9-git-send-email-felipe.contreras@gmail.com>
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4BBC5C8A@dlee03.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> -	if (cpu_is_omap3430()) {
> +	if (false);

-- Is this statement needed ?

> +#if defined(CONFIG_ARCH_OMAP3430)
> +	else if (cpu_is_omap3430()) {
>  		list = omap3_mboxes;
> 
>  		list[0]->irq = res[1].start;

Thank you,
Best regards,
Hari
  	
