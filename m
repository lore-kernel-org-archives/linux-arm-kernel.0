From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 24 Oct 2013 10:11:13 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131024080126.GU30088@pengutronix.de>
References: <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131024080126.GU30088@pengutronix.de>
Message-ID: <20131024081113.GF9403@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 10:01:26AM +0200, Sascha Hauer wrote:
> On Wed, Oct 23, 2013 at 11:29:55AM -0600, Jason Gunthorpe wrote:
> > On Wed, Oct 23, 2013 at 10:06:31AM +0200, Richard Cochran wrote:
> > > On Tue, Oct 22, 2013 at 11:13:46AM -0600, Jason Gunthorpe wrote:
> > > > The question I asked last time this came up, which was left unaswered:
> > > > 
> > > >  Who does this stable DT ABI vision benifit, and how much is that
> > > >  benifit worth?
> > > 
> > > [Sigh]
> > > 
> > > I already answered this question more than once. I guess it doesn't
> > > hurt to answer it again: It helps the users. Please, don't forget
> > > about them.
> > 
> > I've seen that nebulous answer before. It is awfully vauge. Don't you
> > think a better, more excting answer is required to commit the kernel
> > community to such a huge amount of work+pain?
> > 
> > What users? What use cases? Who exactly?
> > 
> > Crucially: Does the above justify the huge effort on the kernel side?
> > 
> > I'm a user of the kernel and I'm sitting here saying I don't need
> > this.
> 
> When you want to create images which run on multiple boards
> (Distribution installers?) you depend on the board being able to
> describe itself. Currently this is the purpose if the devicetree, so it
> really makes sense to put it on the board.
> 
> I'm not mandating a 100% stable devicetree and I think the devicetree
> in firmware still needs to be exchangable. Anyway, incompatible changes
> will cause pain for users who don't ship a devicetree with each kernel.

Okay. I think we all can agree that we won't find one single answer to
this. But I don't think we need to. That's why I keep saying we should
give users a choice. If somebody wants to use only stable bindings
because they can't or don't want to ship DTB updates along with kernel
updates, then by all means, let give them that option.

At the same time I don't think we should force *everyone* to abide by
the same restrictions. People have said that they don't care about the
bindings being experimental and changing in incompatible ways, and if
they don't mind updating the DTB along with every kernel update, then
why wouldn't we want to give them that option as well?

Every discussion about this topic so far seems to have concluded with
one party saying that we absolutely must have stable bindings and the
other party saying that we don't. We can certainly go on doing that
forever, or we find a compromise that both parties can live with.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131024/fe198fbe/attachment-0001.sig>
