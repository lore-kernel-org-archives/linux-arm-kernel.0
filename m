From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Jul 2015 04:01:50 -0700
Subject: [PATCH] ARM: dts: am437x: add aliases for all UART instances
In-Reply-To: <b1af39962d1cae5c344e8593ca738c825af40955.1437390674.git.nsekhar@ti.com>
References: <b1af39962d1cae5c344e8593ca738c825af40955.1437390674.git.nsekhar@ti.com>
Message-ID: <20150721110150.GC17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sekhar Nori <nsekhar@ti.com> [150720 04:15]:
> Add serialN aliases for all 6 UART instances on
> the AM437x SoC so each board's .dts file does not
> have to define its own aliases.
> 
> Remove the alias added for am437x-gp-evm.dts now
> that we have the aliases defined in am4372.dtsi
> file.

Applying both into omap-for-v4.3/dt thanks.

Tony
