From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 19 May 2013 09:13:26 +0200
Subject: [PATCH 2/2] ARM: mvebu: Add support for NOR flash device on
 Armada XP-DB board
In-Reply-To: <20130517165656.GE11137@titan.lakedaemon.net>
References: <1368788998-4672-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1368788998-4672-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130517165656.GE11137@titan.lakedaemon.net>
Message-ID: <20130519091326.74a77b91@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Fri, 17 May 2013 12:56:56 -0400, Jason Cooper wrote:
> On Fri, May 17, 2013 at 08:09:58AM -0300, Ezequiel Garcia wrote:
> > The Armada XP Development Board (DB-78460-BP) has a NOR flash device
> > connected to the Device Bus. This commit adds the device tree node
> > to support this device.
> > 
> > This SoC supports a flexible and dynamic decoding window allocation
> > scheme; but since this feature is still not implemented we need
> > to specify the window base address in the device tree node itself.
> > 
> > This base address has been selected in a completely arbitrary fashion.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/armada-xp-db.dts | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> 
> Applied to mvebu/fixes

Is mvebu/fixes the branch intended to be pushed to 3.10-rcX, or to
3.11 ?

I'm asking because you've applied both 1/2 and 2/2 on the same
mvebu/fixes branch, while 1/2 is intended for 3.10-rcX (fixing
existing DT data), and 2/2 is intended for 3.11 (adding support for a
new device in the DT).

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
