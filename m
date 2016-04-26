From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Apr 2016 10:14:39 -0700
Subject: [PATCH v1] ARM: dts: omap3-n900: Specify peripherals LDO
 regulators initial mode
In-Reply-To: <20160424100830.GC23015@amd>
References: <20160417122933.GA8093@earth>
 <1460903363-2197-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160424100830.GC23015@amd>
Message-ID: <20160426171439.GF5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [160424 03:09]:
> On Sun 2016-04-17 17:29:23, Ivaylo Dimitrov wrote:
> > Without that, regulators are left in the mode last set by the bootloader or
> > by the kernel the device was rebooted from. This leads to various problems,
> > like non-working peripherals.
> > 
> > Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> 
> Reviewed-by: Pavel Machek <pavel@ucw.cz>

Thanks applying into omap-for-v4.6/fixes-rc5.

Tony
