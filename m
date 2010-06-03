From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Thu, 3 Jun 2010 09:57:54 +0200
Subject: [PATCH 2/2] at91sam9g20ek: add fixed-value regulator for wm8731
In-Reply-To: <1275059443-10100-2-git-send-email-dbaryshkov@gmail.com>
References: <1275059443-10100-1-git-send-email-dbaryshkov@gmail.com>
	<1275059443-10100-2-git-send-email-dbaryshkov@gmail.com>
Message-ID: <AANLkTil9KtG3QZDXqBtu63SzitW63u_lGDOa3Q8-l9MZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Dmitry,

> If CONFIG_REGULATOR is enabled, wm8731 fails on AT91SAM9G20EK board,
> since codec driver requires several voltage supplies and none are
> provided currently. As requires voltages are hardwired to 3V3, use fixed
> voltage regulator for this chip.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Acked-by: Andrew Victor <linux@maxim.org.za>

Please submit to the patch system.
