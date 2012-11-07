From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 Nov 2012 13:36:12 -0700
Subject: vexpress issues in next-20121029
In-Reply-To: <508EE610.9050703@wwwdotorg.org>
References: <508EE610.9050703@wwwdotorg.org>
Message-ID: <509AC63C.1070309@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2012 02:24 PM, Stephen Warren wrote:
> Pawel,
> 
> I see two issues on vexpress in next-20121029:
...
> 2) With those calls commented out, I find that
> vexpress_sysreg_init_leds() is device_initcall, and so executes even
> when not running on vexpress HW. This crashes on Tegra (which I have
> converted to single-zImage locally).

This issue still appears to be present in next-20121107.
