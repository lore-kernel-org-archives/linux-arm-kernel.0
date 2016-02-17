From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Feb 2016 10:45:40 +0100
Subject: [PATCH v2 1/3] input: cygnus-update touchscreen dt node document
In-Reply-To: <1455702226-20599-2-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1455702226-20599-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1455702226-20599-2-git-send-email-raveendra.padasalagi@broadcom.com>
Message-ID: <13357929.DDBX61jLXt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 February 2016 15:13:44 Raveendra Padasalagi wrote:
> +
> +       ts_adc_syscon: ts_adc_syscon at 0x180a6000 {
> +               compatible = "syscon";
> +               reg = <0x180a6000 0xc30>;
> +       };
> 

This should have a more specific compatible string in addition to the
generic "syscon" one.

	Arnd
