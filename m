From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Fri, 13 Jun 2014 17:38:05 +0300
Subject: [PATCH 2/3] ata: Add Qualcomm ARM SoC AHCI SATA host controller
 driver
In-Reply-To: <1402600404-19214-2-git-send-email-galak@codeaurora.org>
References: <1402600404-19214-1-git-send-email-galak@codeaurora.org>
 <1402600404-19214-2-git-send-email-galak@codeaurora.org>
Message-ID: <539B0CCD.9060509@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kumar,

> +
> +static struct platform_driver qcom_ahci_driver = {
> +	.probe = qcom_ahci_probe,
> +	.remove = ata_platform_remove_one,
> +	.driver = {
> +		.name = "qcom_ahci_qcom",
> +		.owner = THIS_MODULE,
> +		.of_match_table = qcom_ahci_of_match,
> +	},
> +};
> +module_platform_driver(qcom_ahci_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm AHCI SATA platform driver");
> +MODULE_LICENSE("GPL");

"GPL v2" ? Or only GPL is intentional?

> +MODULE_ALIAS("ahci:qcom");
> 

missing MODULE_AUTHOR

-- 
regards,
Stan
