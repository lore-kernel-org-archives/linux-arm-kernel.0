From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 08 Apr 2013 22:47:09 +0200
Subject: [PATCH] pinctrl: sunxi: Rename wemac functions to emac
In-Reply-To: <1364389953-20688-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1364389953-20688-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <51632CCD.6080900@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Le 27/03/2013 14:12, Maxime Ripard a ?crit :
> The pin functions associated to the ethernet controller were introduced
> with the label "wemac", which was the name of the ethernet driver in the
> allwinner source tree, while the real name of the IP is actually "emac",
> as advertised in several documents including the datasheet.
> 
> Since this is part of the device tree bindings, and that these part of
> the bindings have not yet be released in a kernel version, it seems like
> the good timing to change it and assure consistency.

This patch depends on patches you applied earlier, could you merge it if
you agree with it?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
