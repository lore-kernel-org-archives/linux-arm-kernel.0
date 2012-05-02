From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 2 May 2012 09:37:47 +0000
Subject: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain, powerdomain &
 PRM support for AM33XX device
In-Reply-To: <alpine.DEB.2.00.1205020325100.19695@utopia.booyaka.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204120207420.29473@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9EA07A@DBDE01.ent.ti.com>
 <20120418231837.GT21106@atomide.com>
 <79CD15C6BA57404B839C016229A409A83E9F9C2D@DBDE01.ent.ti.com>
 <20120426184312.GY3739@atomide.com>
 <79CD15C6BA57404B839C016229A409A83E9FF9EA@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1205020325100.19695@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA10A80@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 15:00:28, Paul Walmsley wrote:
> 
> Hello Vaibhav,
> 
> I've reworked these patches somewhat to separate the PRM and CM changes 
> into their own patches.  Also, the omap_hwmod changes have been separated 
> and moved into a different series, as have the clock tree changes.
> 
> So now, pending for 3.5, there are the SCM, voltagedomain, PRM, CM, 
> powerdomain, and clockdomain changes.  Under the (probably incorrect) 
> assumption that Tony will opt to create a CONFIG_ARCH_OMAPAM33XX, you 
> might wish to take a look at the 'am33xx_prcm_devel_3.5' branch of 
> git://git.pwsan.com/linux-2.6.  It is based on four patches, not yet 
> upstream, which create the appropriate board file, Kconfig options, etc.
> 
> Once we're able to reach a conclusion as to which of the CONFIG_ARCH_OMAP* 
> options the AM33xx belongs under, this branch will be updated and 
> reposted, and if everyone is happy with it, proposed for pulling. 
> 
> 

Sounds Great and Thanks a lot Paul.

I will look at the above branch and update you if I find something 
wrong/missing.

Thanks,
Vaibhav
