From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 14 Oct 2015 16:27:57 +0100
Subject: [PATCH 1/2] ARM: dts: fix gpio-keys wakeup-source property
In-Reply-To: <1444743164-17735-1-git-send-email-sudeep.holla@arm.com>
References: <1444743164-17735-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <561E747D.1040100@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 13/10/15 14:32, Sudeep Holla wrote:
> The keyboard driver for GPIO buttons(gpio-keys) checks for one of the
> two boolean properties to enable gpio buttons as wakeup source:
> 1. "wakeup-source" or
> 2. the legacy "gpio-key,wakeup"
>
> However juno, ste-snowball and emev2-kzm9d dts file have a undetected
> "wakeup" property to indictate the wakeup source.
>
> This patch fixes it by making use of "wakeup-source" property.
>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Please review this and provide ack if you are fine with the change for
ste-snowball. I can then ask arm-soc guys to pick this up as fix for v4.3

-- 
Regards,
Sudeep
