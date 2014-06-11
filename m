From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 11 Jun 2014 14:24:12 -0400 (EDT)
Subject: [PATCH v4 3/6] drivers: cpuidle: implement OF based idle states
 infrastructure
In-Reply-To: <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LFD.2.11.1406111420450.25775@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Jun 2014, Lorenzo Pieralisi wrote:

> +config OF_IDLE_STATES
> +        bool "Idle states DT support"
> +	depends on ARM || ARM64
> +	default n

The default for default is n already, so you don't have to default to 
the default's default.


Nicolas
