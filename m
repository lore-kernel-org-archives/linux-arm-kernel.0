From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Dec 2014 20:38:15 +0100
Subject: [PATCH v3 1/5] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <1418064468-8512-3-git-send-email-rjui@broadcom.com>
References: <1418064468-8512-3-git-send-email-rjui@broadcom.com>
Message-ID: <2129851.JzMQjVqeL2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 December 2014 10:47:44 Ray Jui wrote:
> +
> +- no-drv-stregnth:
> +    Specifies the GPIO controller does not support drive strength configuration
> +
> 

Typo:

	strength, not stregnth

Otherwise looks good.

	Arnd
