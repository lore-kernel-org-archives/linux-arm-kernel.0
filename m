From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 26 Jun 2013 17:41:38 +0000 (UTC)
Subject: OMAP baseline test results for v3.10-rc6
In-Reply-To: <alpine.DEB.2.02.1306261641040.6135@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
 <20130625160243.GE22312@arwen.pp.htv.fi>
 <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83ECC9548@DBDE04.ent.ti.com>
 <alpine.DEB.2.02.1306261641040.6135@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1306261741010.6135@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Jun 2013, Paul Walmsley wrote:

> On Wed, 26 Jun 2013, Hiremath, Vaibhav wrote:
> 
> > That?s not quite true, I remember going through your log in detail multiple
> > Times.
> > 
> > The issue is, for appended DTB you must enable 2 config options,
> > 
> > CONFIG_ARM_APPENDED_DTB = y
> > CONFIG_ARM_ATAG_DTB_COMPAT = y
> 
> Maybe you should look again.  Both of these options are set in the 
> am33xx_only Kconfig which is used here for the Beaglebone-White boot.

(and I do appreciate the attention you brought to looking into this issue 
a few months ago)


- Paul
