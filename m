From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 Mar 2017 08:07:39 -0700
Subject: [PATCHv2 8/9] ARM: dts: omap4: add clkctrl nodes
In-Reply-To: <3a82add5-7d85-458c-f8c1-9e58db6a8949@ti.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <1489741781-12816-9-git-send-email-t-kristo@ti.com>
 <20170317154333.GW20572@atomide.com>
 <9456caee-4f45-044a-0b2e-305fa2d0d274@ti.com>
 <b602ccba-489f-e78f-0011-6d808bca9f84@ti.com>
 <20170320143538.GH20572@atomide.com>
 <3a82add5-7d85-458c-f8c1-9e58db6a8949@ti.com>
Message-ID: <20170320150738.GJ20572@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [170320 07:54]:
> - You can introduce the DTS changes on a clkctrl module basis, e.g.
> introduce the node for l4_per_clkctrl along with the clock node changes for
> the same

I don't mind introducing them all at once, I'm worried about
reverting in case of trouble. But as long as we can revert things on
a clkctrl module basis in case of trouble, we should be good to go as
far as I'm concerned.

Regards,

Tony
