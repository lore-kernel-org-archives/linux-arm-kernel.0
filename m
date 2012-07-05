From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 Jul 2012 02:53:51 -0700
Subject: [PATCH-V3 1/3] ARM: OMAP2+: CLEANUP: All OMAP2PLUS uses
 omap-device.o target so add one entry
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA632CE@DBDE01.ent.ti.com>
References: <1340895567-22766-1-git-send-email-hvaibhav@ti.com>
 <1340895567-22766-2-git-send-email-hvaibhav@ti.com>
 <20120704072758.GP1122@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA632CE@DBDE01.ent.ti.com>
Message-ID: <20120705095351.GA1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [120704 02:21]:
> On Wed, Jul 04, 2012 at 12:57:58, Tony Lindgren wrote:
> >
> > This patch did not apply for some reason, I got:
> > 
> > patching file arch/arm/plat-omap/Makefile
> > patch: **** malformed patch at line 73: 1.7.0.4
> > 
> > So please tune up your scripts a bit to the patches can be applied
> > as they are without manual editing ;)
> > 
> 
> Hmmmm...
> 
> I usually submit the patch against linux-omap/master (to handle cross 
> dependencies), which in some cases fails on other branches you maintain. 
> Probably I will make sure that it allies atleast to relevant branches, for 
> example, in this case it should be applied on linux-omap/cleanup branch as 
> well. 

The malformed patch error usually means that something messed up
the patch, like the mail server.. Maybe tabs got replaced with spaces
or something?

Tony
