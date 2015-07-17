From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jul 2015 11:46:05 +0100
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <20150715213818.55c5b3d8@gandalf.local.home>
References: <DAAB1BC4-B36E-436D-8EAD-548641E58490@gmail.com>
 <20150714093154.4d73e551@gandalf.local.home>
 <55A5A75A.1060401@linaro.org>
 <20150714225105.6c1e4f15@gandalf.local.home>
 <55A646EE.6030402@linaro.org>
 <20150715105536.42949ea9@gandalf.local.home>
 <20150715121337.3b31aa84@gandalf.local.home>
 <55A6FA82.9000901@linaro.org> <55A703F3.8050203@linaro.org>
 <20150715213818.55c5b3d8@gandalf.local.home>
Message-ID: <20150717104605.GK18994@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Thu, Jul 16, 2015 at 02:38:18AM +0100, Steven Rostedt wrote:
> On Thu, 16 Jul 2015 10:08:03 +0900
> AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> 
> > On 07/16/2015 09:27 AM, AKASHI Takahiro wrote:
> > > On 07/16/2015 01:13 AM, Steven Rostedt wrote:
> > >> On Wed, 15 Jul 2015 10:55:36 -0400
> > >> Steven Rostedt <rostedt@goodmis.org> wrote:
> > >>
> > >>
> > >>> I'll take a look at it and try to clean up the code.
> > >>
> > >> Does the  following patch make sense for you?
> > >
> > > Looks nice. The patch greatly simplifies changes on arm64 side.
> > 
> > As follows:
> > 
> > - Takahiro AKASHI
> > 
> 
> How should we go forward with this. Want me to make my change to my
> tree, and pull this patch in with it? I can set up for a 4.3 release.
> 
> Then if I can get an Acked-by from one of the arm64 maintainers, I can
> have this go through my tree?

To be honest, I've completely lost track of this thread!

Once you and Akashi have settled on a way forward, I'm happy to take a look
at anything touching arch/arm64/, but it seems like you're still discussing
some aspects of the series atm.

Will
