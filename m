From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 24 Oct 2013 10:01:26 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023172955.GA17145@obsidianresearch.com>
References: <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
Message-ID: <20131024080126.GU30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 11:29:55AM -0600, Jason Gunthorpe wrote:
> On Wed, Oct 23, 2013 at 10:06:31AM +0200, Richard Cochran wrote:
> > On Tue, Oct 22, 2013 at 11:13:46AM -0600, Jason Gunthorpe wrote:
> > > The question I asked last time this came up, which was left unaswered:
> > > 
> > >  Who does this stable DT ABI vision benifit, and how much is that
> > >  benifit worth?
> > 
> > [Sigh]
> > 
> > I already answered this question more than once. I guess it doesn't
> > hurt to answer it again: It helps the users. Please, don't forget
> > about them.
> 
> I've seen that nebulous answer before. It is awfully vauge. Don't you
> think a better, more excting answer is required to commit the kernel
> community to such a huge amount of work+pain?
> 
> What users? What use cases? Who exactly?
> 
> Crucially: Does the above justify the huge effort on the kernel side?
> 
> I'm a user of the kernel and I'm sitting here saying I don't need
> this.

When you want to create images which run on multiple boards
(Distribution installers?) you depend on the board being able to
describe itself. Currently this is the purpose if the devicetree, so it
really makes sense to put it on the board.

I'm not mandating a 100% stable devicetree and I think the devicetree
in firmware still needs to be exchangable. Anyway, incompatible changes
will cause pain for users who don't ship a devicetree with each kernel.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
