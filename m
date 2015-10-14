From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 14 Oct 2015 15:09:35 +0200
Subject: [PATCH 0/4] ARM: berlin: improve multi_v7_defconfig support
In-Reply-To: <6303906.JnZ5PeFoqZ@wuerfel>
References: <1444818844-2865-1-git-send-email-antoine.tenart@free-electrons.com>
 <6303906.JnZ5PeFoqZ@wuerfel>
Message-ID: <20151014130935.GD20884@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Oct 14, 2015 at 02:36:21PM +0200, Arnd Bergmann wrote:
> On Wednesday 14 October 2015 12:34:00 Antoine Tenart wrote:
> > 
> > Some drivers used on a Marvell Berlin kernel were missing from
> > multi_v7_defconfig. This series add them.
> 
> Adding them is great, but we try to have as much as possible
> in loadable modules for new additions. Can you do this?

Sure, I'll do this for the Ethernet and the ADC drivers. But we already
have the SATA and USB features built-in with multi_v7_defconfig, so I'll
keep the two PHY drivers built-in.

> Having a single patch instead of four different ones is fine too,
> by the way.

And I'll put them into a single patch.

Thanks,

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
