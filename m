From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 26 Jun 2015 10:15:47 +0200
Subject: Support CONFIG_CMDLINE for arm64?
In-Reply-To: <CAErSpo4=11L8QPdeJRFrxR_E7sL+sg2T51TN8KcjmPQoo2Oy=g@mail.gmail.com>
References: <CAErSpo4=11L8QPdeJRFrxR_E7sL+sg2T51TN8KcjmPQoo2Oy=g@mail.gmail.com>
Message-ID: <2937668.KYNC73kFne@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

Am Donnerstag, 25. Juni 2015, 17:02:41 schrieb Bjorn Helgaas:
> arch/arm64/Kconfig mentions CONFIG_CMDLINE, but I don't see any actual
> support for it.  Would you be interested in support for it?  Or would
> you rather remove it from Kconfig?

just stumbled over your mail by chance.

CONFIG_CMDLINE is for example included in drivers/of/fdt.c, so will be handled 
correctly for devicetree-based arm64 platforms - and I'm actually using it on 
my rk3368 board :-) .


Heiko
