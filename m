From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Aug 2017 12:05:57 -0700
Subject: [PATCH 12/15] arm-soc: omap: replace open coded VA->PA
 calculations
In-Reply-To: <20170805205222.19868-13-ard.biesheuvel@linaro.org>
References: <20170805205222.19868-1-ard.biesheuvel@linaro.org>
 <20170805205222.19868-13-ard.biesheuvel@linaro.org>
Message-ID: <20170809190556.GD3934@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ard Biesheuvel <ard.biesheuvel@linaro.org> [170805 13:54]:
> This replaces a couple of open coded calculations to obtain the
> physical address of a far symbol with calls to the new adr_l etc
> macros.

I gave this series a quick test and omap3 no longer boots it seems.

Regards,

Tony
