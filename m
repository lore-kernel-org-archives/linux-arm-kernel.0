From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jul 2012 17:18:10 +0000
Subject: [PATCH 1/7] RTC: add DT bindings to pxa-rtc
In-Reply-To: <1343233066-15397-2-git-send-email-zonque@gmail.com>
References: <1343233066-15397-1-git-send-email-zonque@gmail.com>
 <1343233066-15397-2-git-send-email-zonque@gmail.com>
Message-ID: <201207251718.11137.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 July 2012, Daniel Mack wrote:
> +* PXA RTC
> +
> +PXA specific RTC driver.
> +
> +Required properties:
> +- compatible : Should be pxa-rtc
> +
> +Examples:
> +
> +rtc at 0 {
> +    compatible = "mrvl,pxa-rtc";
> +};

The description doesn't match the example here, I think you should
change both to marvell,pxa-rtc.

	Arnd
