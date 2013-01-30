From: balbi@ti.com (Felipe Balbi)
Date: Wed, 30 Jan 2013 15:15:04 +0200
Subject: [PATCH v2 00/30] USB: omap-ehci: Move PHY management to PHY driver
In-Reply-To: <510916B2.7080509@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA95DF0@DBDE01.ent.ti.com>
 <510916B2.7080509@ti.com>
Message-ID: <20130130131504.GU15258@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 30, 2013 at 02:48:50PM +0200, Roger Quadros wrote:
> On 01/30/2013 02:08 PM, Mohammed, Afzal wrote:
> > Hi Roger,
> > 
> > On Mon, Jan 28, 2013 at 17:00:01, Quadros, Roger wrote:
> > 
> >> NOTE: Tested on 4460ES-B1 Panda and BeagleBoard C4 only. Other boards are only
> >> build tested.
> > 
> > Please try to ensure that beagle bone USB0 works with this.
> > 
> 
> Hi Afzal,
> 
> I do not have beaglebone with me and don't seem to find beaglebone
> board support in mainline.

beagle bone is DT-only :-) (see arch/arm/boot/dts/am335x-bone.dts)

> I would appreciate if someone who knows more about beaglebone can help
> with verification.
> 
> I could find that Robert C Nelson (now in cc) is maintaining out of tree
> patches for the beaglebone. Maybe he could help with verification?

Right, Afzal if you have the bone could you help Roger validating ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130130/073d5e53/attachment.sig>
