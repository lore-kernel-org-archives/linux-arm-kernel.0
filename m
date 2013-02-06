From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 6 Feb 2013 22:20:36 +0000 (UTC)
Subject: OMAP baseline test results for v3.8-rc4
In-Reply-To: <alpine.DEB.2.00.1302062141480.12769@utopia.booyaka.com>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
 <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
 <B5906170F1614E41A8A28DE3B8D121433ECFA0FC@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302062141480.12769@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1302062218580.12769@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Feb 2013, Paul Walmsley wrote:

> Setting CONFIG_EARLY_PRINTK=n doesn't fix the problem I'm seeing.

And just tried this with u-boot v2013.01 on a BeagleBoard A6a, does not 
fix it.

> > If you still have issues booting can you update your U-Boot to v2013.01 since things
> > seem to be working fine at this point.
> 
> Let's try to identify and get rid of bootloader dependencies in the 
> kernel.  They indicate that the kernel isn't initializing something 
> appropriately, which could cause strange problems later.

Oh and it's worth noting that parts of u-boot v2013.01 don't work 
correctly on earlier BeagleBones, i.e. Ethernet booting.


- Paul
