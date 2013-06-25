From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 25 Jun 2013 12:00:47 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gYXJtOiBlcDkzeHg6IHVzZSBzb2MgYnVz?=
In-Reply-To: <201306241753.21929.hartleys@visionengravers.com>
References: <201306241753.21929.hartleys@visionengravers.com>
Message-ID: <1372147247.546760685@f94.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Use the soc bus to report the silicon revidion and Maverick Key. Both
> are not currently exposed to the user. In addition, fill in the SoC
> family and machine for completeness.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
...
> +	soc_dev_attr->machine = ep93xx_get_machine_name();
> +	soc_dev_attr->family = "Cirrus EP93xx";

Probably, use full name here is better?
"Cirrus Logic EP93xx"

> +	soc_dev_attr->revision = ep93xx_get_soc_rev();
> +	soc_dev_attr->soc_id = ep93xx_get_soc_id();
...
---
