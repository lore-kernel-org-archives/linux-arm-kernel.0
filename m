From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 12 Feb 2014 11:09:42 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAwNy8xMl0gbWZkOiBzeXNjb246IENvbnNpZGVyIHBsYXRm?=
 =?UTF-8?B?b3JtIGRhdGEgYSByZWdtYXAgY29uZmlnIG5hbWU=?=
In-Reply-To: <1392138636-29240-8-git-send-email-pawel.moll@arm.com>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
 <1392138636-29240-8-git-send-email-pawel.moll@arm.com>
Message-ID: <1392188982.914924525@f237.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

???????, 11 ??????? 2014, 17:10 UTC ?? Pawel Moll <pawel.moll@arm.com>:
> Use the device platform data as a regmap config
> name. This is particularly useful in the regmap
> debugfs when there is more than one syscon device
> registered, to distinguish the register blocks.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
...
> syscon_regmap_config.max_register = res->end - res->start - 3;
> +	syscon_regmap_config.name = dev_get_platdata(&pdev->dev);

Is dev_name(&pdev->dev) can be used for such purpose?

Thanks.
---
