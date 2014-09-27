From: pramod.gurav@smartplayin.com (Pramod Gurav)
Date: Sat, 27 Sep 2014 13:37:46 +0530
Subject: [PATCH v7 1/7] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <1411779495-39724-2-git-send-email-lina.iyer@linaro.org>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
 <1411779495-39724-2-git-send-email-lina.iyer@linaro.org>
Message-ID: <54267052.7020907@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 27-09-2014 06:28 AM, Lina Iyer wrote:
> Based on work by many authors, available at codeaurora.org
> 

..

> +int qcom_spm_set_low_power_mode(enum spm_mode mode)
> +{
> +	struct spm_driver_data *drv = &__get_cpu_var(cpu_spm_drv);
> +	u32 start_addr = 0;
initialization not necessary.

> +	u32 ctl_val;
> +
> +	if (!drv || !drv->reg_data)

..

> +#endif  /* __QCOM_SPM_H */
> 
