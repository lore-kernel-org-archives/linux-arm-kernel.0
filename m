From: balbi@ti.com (Felipe Balbi)
Date: Tue, 30 Oct 2012 20:48:28 +0200
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <20121030182007.GA21851@core.coreip.homeip.net>
References: <20121026062008.GA21734@arwen.pp.htv.fi>
 <20121026160316.GY18814@opensource.wolfsonmicro.com>
 <20121029194901.GA30152@arwen.pp.htv.fi>
 <20121030112410.GM4511@opensource.wolfsonmicro.com>
 <20121030114949.GC28722@arwen.pp.htv.fi>
 <20121030140714.GO4511@opensource.wolfsonmicro.com>
 <20121030151642.GE29159@arwen.pp.htv.fi>
 <20121030155821.GU4511@opensource.wolfsonmicro.com>
 <20121030172513.GA3993@arwen.pp.htv.fi>
 <20121030182007.GA21851@core.coreip.homeip.net>
Message-ID: <20121030184828.GB4804@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 30, 2012 at 11:20:07AM -0700, Dmitry Torokhov wrote:
> On Tue, Oct 30, 2012 at 07:25:13PM +0200, Felipe Balbi wrote:
> > On Tue, Oct 30, 2012 at 03:58:21PM +0000, Mark Brown wrote:
> > > 
> > > But then this comes round to the mindless code that ought to be factored
> > > out :)  Only the more interesting cases that do something unusual really
> > > register here.
> > 
> > fair enough. I see your point. Not saying I agree though, just that this
> > discussion has been flying for far too long, so feel free to provide
> > patches implementing what you're defending here ;-)
> > 
> > Guess code will speak for itself. On way or another, we need OMAP keypad
> > driver working in mainline
> 
> Are you saying that introducing pincrtl infrastructure actually _broke_
> the driver in mainline?

no dude, I'm saying we need pinctrl working for this driver because we
need to remove OMAP-specific MUX settings. One way or another, this has
to work.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121030/aed14ccb/attachment.sig>
