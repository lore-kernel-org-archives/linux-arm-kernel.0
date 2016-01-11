From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Jan 2016 15:34:39 -0800
Subject: [PATCH] arm: omap2plus_defconfig: enable SPLIT and DWARF4
In-Reply-To: <1452547572-23515-1-git-send-email-balbi@ti.com>
References: <1452547572-23515-1-git-send-email-balbi@ti.com>
Message-ID: <20160111233438.GB12777@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [160111 13:26]:
> CONFIG_DEBUG_INFO_SPLIT will split debug info on
> .dwo files. This will generate a smaller vmlinux and
> smaller .ko modules, which will be easier to ship on
> certain products.
> 
> CONFIG_DEBUG_INFO_DWARF4 will generate debug info in
> DWARF4 format, which ends up being larger, but
> improves the probability of resolving variables in
> optmized code.

Nice, this makes my initramfs go down from about 17MB
to 4.7 MB :)

Regards,

Tony
