From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 16 Feb 2016 09:56:54 +0000
Subject: [PATCH] ARM: dts: r8a7794: replace gpio-key,wakeup with
 wakeup-source property
In-Reply-To: <1455572925-27697-1-git-send-email-horms+renesas@verge.net.au>
References: <1455572925-27697-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <56C2F266.5030709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/02/16 21:48, Simon Horman wrote:
> Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
> check for/support the legacy "gpio-key,wakeup" boolean property to
> enable gpio buttons as wakeup source, "wakeup-source" is the new
> standard binding.
>
> This patch replaces the legacy "gpio-key,wakeup" with the unified
> "wakeup-source" property in order to avoid any futher copy-paste
> duplication.
>
> Changelog text from a similar patch by Sudeep Holla.
>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Thanks for doing this, not sure how I missed it, was this merged in v4.5?

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
