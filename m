From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 30 Apr 2012 19:40:46 +0000
Subject: [PATCH] ARM: OMAP2+: control: Add AM33XX control reg & sec
 clkctrl offset
In-Reply-To: <alpine.DEB.2.00.1204271834260.10308@utopia.booyaka.com>
References: <1332327499-29946-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204271834260.10308@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA0CAEF@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 28, 2012 at 06:06:40, Paul Walmsley wrote:
> Hi Vaibhav
> 
> On Wed, 21 Mar 2012, Vaibhav Hiremath wrote:
> 
> > Define AM33XX control register, in order to allow access to
> > control register address space, also add CONTROL_SEC_CLK_CTRL
> > register offset; both are required in clock tree data,
> > for wdt0 and timer0 clock source select configuration.
> > 
> > CONTROL.SEC_CLK_CTRL register is provided to select/configure
> > clock input for WDT0 and TIMER0.
> 
> This patch has been updated so it builds, and also updated to add some 
> AM33XX macros needed for the clock tree and to fix some control.h 
> whitespace problems; updated version below.  Could you please take a quick 
> look and see if it is okay with you?
> 

Patch looks ok to me, so you can merge it. 
And thanks for adding sysboot shift/mask bits, one less patch for me :)

Thanks,
Vaibhav
