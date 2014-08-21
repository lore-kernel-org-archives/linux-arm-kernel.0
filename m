From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 21 Aug 2014 20:47:44 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAzLzNdIEFSTTogZHRzOiBrZXlzdG9uZS1rMmhrOiBh?=
 =?UTF-8?B?ZGQgZHNwIGdwaW8gY29udHJvbGxlcnMgbm9kZXM=?=
In-Reply-To: <1408638203-8246-4-git-send-email-grygorii.strashko@ti.com>
References: <53ECE9B1.4060303@ti.com>
 <1408638203-8246-1-git-send-email-grygorii.strashko@ti.com>
 <1408638203-8246-4-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1408639664.245146808@f420.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thu, 21 Aug 2014 19:23:23 +0300 ?? Grygorii Strashko <grygorii.strashko@ti.com>:
> Add Keystone 2 DSP GPIO nodes.
> DSP GPIO banks 0-7 correspond to DSP0-DSP7
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
...
> +		dspgpio3: keystone_dsp_gpio at 0262024c {
> +			compatible = "ti,keystone-dsp-gpio3";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
...
> +		dspgpio7: keystone_dsp_gpio at 0262025C {

Use lower case for addresses.

---
