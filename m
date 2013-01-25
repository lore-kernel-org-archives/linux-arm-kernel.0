From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 25 Jan 2013 08:42:05 +0000 (UTC)
Subject: OMAP baseline test results for v3.8-rc4
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ECFA0FC@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
 <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
 <B5906170F1614E41A8A28DE3B8D121433ECFA0FC@DBDE01.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1301250838410.471@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 24 Jan 2013, Bedia, Vaibhav wrote:

> Can you update your AM335x-only config to disable CONFIG_EARLY_PRINTK or 
> just skip earlyprintk option in the bootargs for now?

I'll give this a try over the next few days.

If EARLY_PRINTK is known to be broken for DT boots, could you please put 
together a Kconfig patch that prevents either EARLY_PRINTK from being 
selected when a DT-only board is selected, or vice-versa?

- Paul
