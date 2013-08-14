From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 14 Aug 2013 16:40:32 -0400 (EDT)
Subject: [Git pull request] fix to the vexpress/mcpm branch
In-Reply-To: <20130814200834.GA24544@quad.lixom.net>
References: <alpine.LFD.2.03.1308121428080.14472@syhkavp.arg>
 <20130814055800.GG16635@quad.lixom.net>
 <alpine.LFD.2.03.1308141018140.14472@syhkavp.arg>
 <20130814200834.GA24544@quad.lixom.net>
Message-ID: <alpine.LFD.2.03.1308141621430.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Aug 2013, Olof Johansson wrote:

> On Wed, Aug 14, 2013 at 10:25:14AM -0400, Nicolas Pitre wrote:
> > On Tue, 13 Aug 2013, Olof Johansson wrote:
> > 
> > > Hi Nico,
> > > 
> > > On Mon, Aug 12, 2013 at 02:37:54PM -0400, Nicolas Pitre wrote:
> > > > 
> > > > Please pull the following:
> > > > 
> > > > 	git://git.linaro.org/people/nico/linux mcpm+tc2
> > > > 
> > > > which will update your vexpress/mcpm branch with one additional commit 
> > > > fixing the build issue with CONFIG_FRAME_POINTER reported by RMK.  This 
> > > > commit's SHA1 is 95fbdc9cf542.
> > > 
> > > So, I just replaced my branch with the one from Pawel, and the topmost patch
> > > in your branch seems to no longer apply.
> > 
> > Weird.  It still applies perfectly here.
> 
> Yep, not sure what happened last night. It applies cleanly now.

Good.

> > Here's the patch nevertheless.  Please apply ASAP as Lorenzo wishes to 
> > base his next pull request on top of this.
> 
> There's always something more, it seems. What's left?

See below.

> And will it really conflict with the bugfix here or is it just to have 
> it all in the same series?

According to Lorenzo's subsequent reply

  http://article.gmane.org/gmane.linux.ports.arm.kernel/260544

there is no conflict to worry about.

> The reason I'm asking is that I applied this on next/soc instead of
> vexpress/mcpm, and we're asking downstream maintainers to not base anthing on
> next/* branches because it _might_ happen that we rebuild them.

Looking into my inbox, I have the following emails from Lorenzo:

  http://article.gmane.org/gmane.linux.power-management.general/36794

  http://article.gmane.org/gmane.linux.power-management.general/37006

  http://article.gmane.org/gmane.linux.power-management.general/37007

  http://article.gmane.org/gmane.linux.ports.arm.kernel/260441

You apparently were CC'd on all of them, and Lorenzo asked you on two 
occasions how you wanted to handle this, and one of them is an explicit 
pull request addressed to you.


Nicolas
