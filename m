From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Aug 2013 00:54:18 -0700
Subject: [PATCHv3 2/9] ARM: OMAP2+: AM33XX: control: Add some control
 module registers and APIs
In-Reply-To: <52055733.70808@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-3-git-send-email-d-gerlach@ti.com>
 <5203A0BC.8060205@ti.com> <5203C457.80301@ti.com>
 <20130809051146.GB7656@atomide.com> <52055733.70808@ti.com>
Message-ID: <20130812075418.GG7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [130809 14:02]:
>
> Ok I will go ahead and pull the control module code that handles IPC
> into the wkup_m3 driver. The wkup_m3.c file is still present in
> mach-omap2 as the right location for it wasn't decided in the last
> RFC. Any thoughts on a good location for it?

Well maybe try to think how to use these features in a Linux
generic way without having to export tons of custom functions?

Regards,

Tony
