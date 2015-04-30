From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Apr 2015 09:42:06 +0200
Subject: [PATCH v3 0/7] ARM: at91/dt: kizbox: update and rename to
 at91-kizbox
In-Reply-To: <1430379218-13758-1-git-send-email-g.portay@overkiz.com>
References: <1430379218-13758-1-git-send-email-g.portay@overkiz.com>
Message-ID: <20150430074206.GE3242@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/04/2015 at 09:33:31 +0200, Ga?l PORTAY wrote :
> Hi,
> 
> This patchset renames the kizbox board into at91-kizbox to match AT91 naming
> convention, sanitize and sorts nodes by address when possible (or
> alphabetically if not applicable).
> 
> It also updates the following features:
> - uses proper serial uart (only USART3 is accessible),
> - fixes gpio-keys active level and rename,
> - moves leds to pwm support (using tcb-pwm driver) and rename as well,
> - re-sizes nand mtd partitions and
> - updates chosen-node (bootargs + set linux stdout path to DBGU),
> 

The whole series is
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
