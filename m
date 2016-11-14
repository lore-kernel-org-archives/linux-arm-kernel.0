From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 14 Nov 2016 17:04:56 +0100
Subject: [PATCH] ARM: dts: at91: replace gpio-key,wakeup with
 wakeup-source for sam9260ek
In-Reply-To: <1479138250-17780-2-git-send-email-sudeep.holla@arm.com>
References: <1479138250-17780-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <20161114160456.xzp3sxwkvl6vmu7l@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/2016 at 15:44:08 +0000, Sudeep Holla wrote :
> Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
> check for/support the legacy "gpio-key,wakeup" boolean property to
> enable gpio buttons as wakeup source, "wakeup-source" is the new
> standard binding.
> 
> This patch replaces the legacy "gpio-key,wakeup" with the unified
> "wakeup-source" property in order to avoid any further copy-paste
> duplication.
> 
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/at91sam9260ek.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
