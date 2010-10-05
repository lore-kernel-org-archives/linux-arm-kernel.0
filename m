From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Oct 2010 11:16:10 -0700
Subject: [PATCHv3 1/1] omap3: Add minimal OMAP3 IGEP module support.
In-Reply-To: <1286057175-22916-2-git-send-email-eballetbo@gmail.com>
References: <1286057175-22916-1-git-send-email-eballetbo@gmail.com>
	<1286057175-22916-2-git-send-email-eballetbo@gmail.com>
Message-ID: <20101005181610.GN3117@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enric Balletbo i Serra <eballetbo@gmail.com> [101002 14:58]:
> The OMAP3 IGEP module is a low-power, high performance production-ready
> system-on-module (SOM) based on TI's OMAP3 family. More about this
> board at www.igep.es.

Adding this to omap-for-linus. Updated it for to use MMC caps instead
of wires and to be selected by default in Kconfig.

Regards,

Tony
