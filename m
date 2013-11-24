From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 24 Nov 2013 08:02:03 -0500
Subject: [PATCHv2] ARM: mvebu: Add Netgear ReadyNAS 2120 board
In-Reply-To: <87y54e819h.fsf@natisbad.org>
References: <87ppq5flnb.fsf@natisbad.org>
 <20131124034951.GY29241@titan.lakedaemon.net>
 <87y54e819h.fsf@natisbad.org>
Message-ID: <20131124130203.GB29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 24, 2013 at 12:52:58PM +0100, Arnaud Ebalard wrote:
> Hi,
> 
> Jason Cooper <jason@lakedaemon.net> writes:
> 
> > On Tue, Nov 12, 2013 at 08:46:48PM +0100, Arnaud Ebalard wrote:
> >> 
> >> All hardware parts of the (mv78230 Armada XP based) NETGEAR ReadyNAS
> >> 2120 are supported by mainline kernel (USB 3.0 and eSATA rear ports,
> >> USB 2.0 front port, Gigabit controller and PHYs for the two rear ports,
> >> serial port, LEDs, Buttons, 88SE9170 SATA controllers, three G762 fan
> >> controllers, G751 temperature sensor) except for:
> >> 
> >>  - the Intersil ISL12057 I2C RTC Chip,
> >>  - the Armada NAND controller.
> >> 
> >> Support for both of those is currently work in progress and does not
> >> prevent boot.
> >> 
> >> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> >> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> >> ---
> > ...
> >>  arch/arm/boot/dts/Makefile                     |   1 +
> >>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 288 +++++++++++++++++++++++++
> >>  2 files changed, 289 insertions(+)
> >>  create mode 100644 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> >
> > Applied to mvebu/dt
> 
> Thanks, Jason. Based on the response to the question raised by Jason
> Gunthorpe regarding PHY compatible string [1], I'll keep in mind to send
> you a patch at some point (.dts file for RN2120 also has compatible =
> "marvell,88e1318s") if needed.

d*mn.  You're right.  I missed that.  I'll drop this from mvebu/dt until
that's resolved.  I don't want to inadvertently force supporting a
compatible string we don't want.

Please resend this once that's resolved.

thx,

Jason.
