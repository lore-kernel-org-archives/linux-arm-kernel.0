From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Jun 2015 23:09:08 +0200
Subject: [PATCH v2 5/5] cpuidle: ARM: Add cpuidle driver for K1879XB1YA
In-Reply-To: <1435677307-6526-6-git-send-email-andrew@ncrmnt.org>
References: <1435677307-6526-1-git-send-email-andrew@ncrmnt.org>
 <1435677307-6526-6-git-send-email-andrew@ncrmnt.org>
Message-ID: <3958914.ao1NLj5AqM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 June 2015 18:15:07 Andrew Andrianov wrote:
> +static struct platform_driver rcm_cpuidle_driver = {
> +       .driver = {
> +               .name   = "cpuidle-rcm-k1879xb1",
> +       },
> +};
> +
> 

Who creates this device?

	Arnd
