From: olof@lixom.net (Olof Johansson)
Date: Wed, 14 Aug 2013 13:08:34 -0700
Subject: [Git pull request] fix to the vexpress/mcpm branch
In-Reply-To: <alpine.LFD.2.03.1308141018140.14472@syhkavp.arg>
References: <alpine.LFD.2.03.1308121428080.14472@syhkavp.arg>
 <20130814055800.GG16635@quad.lixom.net>
 <alpine.LFD.2.03.1308141018140.14472@syhkavp.arg>
Message-ID: <20130814200834.GA24544@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 10:25:14AM -0400, Nicolas Pitre wrote:
> On Tue, 13 Aug 2013, Olof Johansson wrote:
> 
> > Hi Nico,
> > 
> > On Mon, Aug 12, 2013 at 02:37:54PM -0400, Nicolas Pitre wrote:
> > > 
> > > Please pull the following:
> > > 
> > > 	git://git.linaro.org/people/nico/linux mcpm+tc2
> > > 
> > > which will update your vexpress/mcpm branch with one additional commit 
> > > fixing the build issue with CONFIG_FRAME_POINTER reported by RMK.  This 
> > > commit's SHA1 is 95fbdc9cf542.
> > 
> > So, I just replaced my branch with the one from Pawel, and the topmost patch
> > in your branch seems to no longer apply.
> 
> Weird.  It still applies perfectly here.

Yep, not sure what happened last night. It applies cleanly now.

> Here's the patch nevertheless.  Please apply ASAP as Lorenzo wishes to 
> base his next pull request on top of this.

There's always something more, it seems. What's left? And will it really
conflict with the bugfix here or is it just to have it all in the same series?

The reason I'm asking is that I applied this on next/soc instead of
vexpress/mcpm, and we're asking downstream maintainers to not base anthing on
next/* branches because it _might_ happen that we rebuild them.


-Olof
