From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Dec 2010 14:28:21 -0800
Subject: [PATCH v2] MTD: NAND: ams-delta: convert to platform driver
In-Reply-To: <201012142109.42784.jkrzyszt@tis.icnet.pl>
References: <201012111840.05270.jkrzyszt@tis.icnet.pl>
	<1292346023.2538.103.camel@localhost>
	<201012142109.42784.jkrzyszt@tis.icnet.pl>
Message-ID: <20101214222821.GA14990@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [101214 12:31]:
> In its current form, the driver may interfere with different hardware on 
> different boards if built into the kernel, hence is not suitable for 
> inclusion into a defconfig, inteded to be usable with multiple OMAP1 cpu and 
> machine types.
> 
> Convert it to a platform driver, that should be free from this issue.
> 
> Created and tested against linux-2.6.37-rc5 on Amstrad Delta.

Good to see this happen, I assume this is for MTD. If not and you
want me to merge it instead, let me know.

Acked-by: Tony Lindgren <tony@atomide.com>
