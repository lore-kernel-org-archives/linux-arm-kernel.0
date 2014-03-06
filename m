From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 6 Mar 2014 13:02:13 -0300
Subject: [PATCH] ARM: mvebu: add Device Tree for the Armada 385 RD board
In-Reply-To: <53189892.5090502@free-electrons.com>
References: <1394107868-26094-1-git-send-email-gregory.clement@free-electrons.com>
 <20140306131429.GJ4780@lunn.ch>
 <5318779C.8030901@free-electrons.com>
 <20140306142117.GL4780@lunn.ch>
 <531886B4.2070002@free-electrons.com>
 <20140306144600.GM4780@lunn.ch>
 <53188B73.4000109@free-electrons.com>
 <53189892.5090502@free-electrons.com>
Message-ID: <20140306160213.GA4327@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mar 06, Gregory CLEMENT wrote:
> On 06/03/2014 15:51, Gregory CLEMENT wrote:
> > the dsi file.
> > 
> > I will have a look on the ethernet driver.
> 
> Well the naming is done in __dev_alloc_name() and it depends on
> the probe order.
> 

Can't we fix this so the probe order doesn't affect the name?

Is that sane?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
