From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Oct 2015 15:23:57 +0200
Subject: [PATCH 0/4] ARM: berlin: improve multi_v7_defconfig support
In-Reply-To: <20151014130935.GD20884@kwain>
References: <1444818844-2865-1-git-send-email-antoine.tenart@free-electrons.com>
 <6303906.JnZ5PeFoqZ@wuerfel> <20151014130935.GD20884@kwain>
Message-ID: <12896673.C2YC2mY5Sr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 October 2015 15:09:35 Antoine Tenart wrote:
> Hi Arnd,
> 
> On Wed, Oct 14, 2015 at 02:36:21PM +0200, Arnd Bergmann wrote:
> > On Wednesday 14 October 2015 12:34:00 Antoine Tenart wrote:
> > > 
> > > Some drivers used on a Marvell Berlin kernel were missing from
> > > multi_v7_defconfig. This series add them.
> > 
> > Adding them is great, but we try to have as much as possible
> > in loadable modules for new additions. Can you do this?
> 
> Sure, I'll do this for the Ethernet and the ADC drivers. But we already
> have the SATA and USB features built-in with multi_v7_defconfig, so I'll
> keep the two PHY drivers built-in.
> 
> 

Ok, fair enough.

	Arnd
