From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 28 Sep 2012 12:15:18 +0200
Subject: [PATCH] ARM: bcm2835: implement machine restart hook
In-Reply-To: <1348805280-7647-1-git-send-email-swarren@wwwdotorg.org>
References: <1348805280-7647-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120928121518.7f88196b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

On Thu, 27 Sep 2012 22:08:00 -0600, Stephen Warren wrote:

> +intc: interrupt-controller {

Isn't this a bizarre name for a watchdog device?

> +	compatible = "brcm,bcm2835-pm-wdog";
> +	reg = <0x7e100000 0x28>;
> +};

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
