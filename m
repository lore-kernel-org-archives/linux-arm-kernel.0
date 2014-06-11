From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Jun 2014 11:46:27 +0200
Subject: [PATCH] phy: sun4i: depend on RESET_CONTROLLER
In-Reply-To: <539824F9.6050302@ti.com>
References: <1400871088-16894-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140611091035.GD4254@lukather> <539824F9.6050302@ti.com>
Message-ID: <20140611094627.GF4254@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 03:14:25PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Wednesday 11 June 2014 02:40 PM, Maxime Ripard wrote:
> > Hi Kishon,
> > 
> > On Fri, May 23, 2014 at 08:51:28PM +0200, Maxime Ripard wrote:
> >> The driver depend on the reset framework in a mandatory way. Make sure
> >> reset_control_get is defined by adding this dependency in Kconfig
> >>
> >> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >> Reported-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Ping?
> 
> Will queue once -rc1 is tagged.

Ok, thanks.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140611/7f0f4472/attachment-0001.sig>
