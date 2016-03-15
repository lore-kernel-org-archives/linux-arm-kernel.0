From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Mar 2016 10:58:02 +0000
Subject: [linux-sunxi] Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line
 and Mic inputs
In-Reply-To: <20160314104939.GL8418@lukather>
References: <20151221123148.1ab6480b@dayas> <20151221123416.51aa938e@dayas>
 <20151227182157.GI30359@lukather> <20151228040649.475a742f@dayas>
 <20160106220908.GE9631@lukather> <20160109164832.515d69b0@dayas>
 <20160312085222.226d89bf@scratchpost.org>
 <20160314104939.GL8418@lukather>
Message-ID: <20160315105802.GN2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2016 at 11:49:39AM +0100, Maxime Ripard wrote:
> On Sat, Mar 12, 2016 at 08:52:22AM +0100, Danny Milosavljevic wrote:

> > > The other direction (making two controls which both do the same and update 
> > > each other's value) doesn't seem to be easily available. 

> > > Should I write a _put handler that does it manually?

> > > (Or should that be handled by alsa-lib mixer modules instead?)

> > > Is it possible to merge the "Left Mixer" control and respective 
> > > "Right Mixer" control into one selem in alsamixer?

> > > Because alsamixer actually has support for one-sided muting.

> Mark, do you know how to do it?

> IIRC, in order to have shared controls, you just needed to share the
> controls structure.

I'm having a really hard time telling what "it" is here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160315/c785145d/attachment.sig>
