From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 23 Sep 2014 16:01:52 +0200
Subject: [PATCH v4 0/9] ARM: Berlin: Ethernet support
In-Reply-To: <3200502.7xjfrZcKCM@wuerfel>
References: <1411474536-22626-1-git-send-email-antoine.tenart@free-electrons.com>
 <3200502.7xjfrZcKCM@wuerfel>
Message-ID: <20140923140152.GD18924@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 02:41:47PM +0200, Arnd Bergmann wrote:
> On Tuesday 23 September 2014 14:15:27 Antoine Tenart wrote:
> > 
> > This series introduce support for the Ethernet controller on Berlin SoCs,
> > using the existing pxa168 Ethernet driver. In order to do this, DT
> > support is added to the driver alongside some other modifications and
> > fixes.
> > 
> 
> Looks great overall, I've commented on two issues I've found, but only
> the phy-addr one really needs to be addressed. Once that is out of the
> way, please add
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
