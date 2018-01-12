From: tony@atomide.com (Tony Lindgren)
Date: Fri, 12 Jan 2018 15:34:54 -0800
Subject: [PATCH] ARM: dts: n900: Add aliases for lcd and tvout displays
In-Reply-To: <1514931434-13192-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1514931434-13192-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <20180112233454.GI4821@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [180102 14:20]:
> When both lcd and tv are enabled, the order in which they will be probed is
> unknown, so it might happen (and it happens in reality) that tv is
> configured as display0 and lcd as display1, which results in nothing
> displayed on lcd, as display1 is disabled by default.
> 
> Fix that by providing correct aliases for lcd and tv

Applying into omap-for-v4.16/dt-clk thanks.

Regards,

Tony
