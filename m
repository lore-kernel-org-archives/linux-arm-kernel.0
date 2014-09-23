From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 14:41:47 +0200
Subject: [PATCH v4 0/9] ARM: Berlin: Ethernet support
In-Reply-To: <1411474536-22626-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1411474536-22626-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <3200502.7xjfrZcKCM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 14:15:27 Antoine Tenart wrote:
> 
> This series introduce support for the Ethernet controller on Berlin SoCs,
> using the existing pxa168 Ethernet driver. In order to do this, DT
> support is added to the driver alongside some other modifications and
> fixes.
> 

Looks great overall, I've commented on two issues I've found, but only
the phy-addr one really needs to be addressed. Once that is out of the
way, please add

Acked-by: Arnd Bergmann <arnd@arndb.de>
