From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 2 Nov 2012 18:26:32 +0000
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <CACRpkdac=ztY0vXQ8Mu6H8fiAO4aFSSF-A6O1Q==zKOKEsJegw@mail.gmail.com>
References: <20121026160316.GY18814@opensource.wolfsonmicro.com>
 <20121029194901.GA30152@arwen.pp.htv.fi>
 <20121030112410.GM4511@opensource.wolfsonmicro.com>
 <20121030114949.GC28722@arwen.pp.htv.fi>
 <20121030140714.GO4511@opensource.wolfsonmicro.com>
 <20121030151642.GE29159@arwen.pp.htv.fi>
 <20121030155821.GU4511@opensource.wolfsonmicro.com>
 <20121030172513.GA3993@arwen.pp.htv.fi>
 <20121030183704.GX4511@opensource.wolfsonmicro.com>
 <CACRpkdac=ztY0vXQ8Mu6H8fiAO4aFSSF-A6O1Q==zKOKEsJegw@mail.gmail.com>
Message-ID: <20121102182632.GF4413@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2012 at 10:51:11PM +0100, Linus Walleij wrote:
> On Tue, Oct 30, 2012 at 7:37 PM, Mark Brown

> > More seriously the amount of time we seem to have been spending recently
> > on changes which end up requiring us to go through essentially every
> > driver and add code to them (often several times) doesn't seem like
> > we're doing a good job here.

> If this is your main concern you should be made aware that there
> are people out there planning to supplant the existing DT probe paths
> that are now being added to each and every ARM-related driver
> with an ACPI probe path as ARM servers come into the picture.

That's different as we're adding support for a new external interface
which will need per device configuration parsing rather than
reorganising things within the kernel; I'd expect it won't supplant DT
but rather sit alongside it as it's more a requirement for the server
market than for the embedded market.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121102/2a2e9cba/attachment.sig>
