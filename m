From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Fri, 31 Jul 2015 17:54:56 +0300
Subject: [PATCH v7 12/13] clk: qcom: gdsc: Add GDSCs in apq8084 MMCC
In-Reply-To: <1438076046-4706-13-git-send-email-rnayak@codeaurora.org>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
 <1438076046-4706-13-git-send-email-rnayak@codeaurora.org>
Message-ID: <55BB8C40.507@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


<snip>

>  
> +static struct gdsc venus0_gdsc = {
> +	.gdscr = 0x1024,
> +	.pd = {
> +		.name = "venus0",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.con_ids = { NULL },
> +};
> +

Rajendra, according to downstream kernel apq8084 has second instance of
gdsc i.e. venus1_gdsc, is that correct?


-- 
regards,
Stan
