From: olof@lixom.net (Olof Johansson)
Date: Sat, 9 Feb 2013 16:29:29 -0800
Subject: [PATCH 6/6] ARM: integrator: ensure ap_syscon_base is
 initialised when !CONFIG_MMU
In-Reply-To: <20130206182512.GB28640@mudshark.cambridge.arm.com>
References: <1359556069-28289-1-git-send-email-will.deacon@arm.com>
 <20130131225630.GB26523@quad.lixom.net>
 <20130203114847.GB27474@mudshark.cambridge.arm.com>
 <201302042149.44727.arnd@arndb.de>
 <20130206182512.GB28640@mudshark.cambridge.arm.com>
Message-ID: <20130210002929.GA16278@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 06:25:12PM +0000, Will Deacon wrote:
> On Mon, Feb 04, 2013 at 09:49:44PM +0000, Arnd Bergmann wrote:
> > On Sunday 03 February 2013, Will Deacon wrote:
> > > I think it's been broken for a little while as it only affects !MMU
> > > configurations, which aren't especially popular. My guess is that
> > > 83feba511e5d ("ARM: integrator: remove static AP syscon mapping") is what
> > > caused the breakage.
> > > 
> > > The fix should apply against mainline.
> > 
> > Sounds like a candidate for stable as well then. I'm not sure if anyone
> > cares about !MMU stable kernels, but it's totally possible with the
> > LTSI kernels.
> 
> Agreed. I've lost where we've got to, so here's the patch against -rc5 with
> the CC stable and Linus' ack.

Applied to fixes-non-critical for 3.9.


-Olof
