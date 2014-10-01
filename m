From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 01 Oct 2014 18:40:14 +0200
Subject: [GIT PULL] ARM: STi: DT changes for v3.18
In-Reply-To: <542C27E4.5070801@st.com>
References: <54215982.2040909@st.com> <201410011707.02238.arnd@arndb.de>
 <542C27E4.5070801@st.com>
Message-ID: <11407277.Nl6ODFGXzA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 October 2014 18:12:20 Maxime Coquelin wrote:
> 
> > 
> > Unfortunately, your submission came a bit late, so no guarantee this is going
> > to make it into 3.18. If we see too many regressions with the earlier branches,
> > we'll defer it for 3.19.
> Yes, I have been busy these days with other topics, but I thought it wasn't too late,
> since it was two weeks before the opening of the merge window.
> 
> For next time, could tell me starting which -rc you consider it is too late?

Linus said last week that he would probably not do an -rc7, in which case it
would have been too late. We don't have a hard rule like "before -rc5". In general,
we like to see the majority of patches sent as early as possible, and then
followed up with smaller changes as we get closer to the merge window.

We're more likely to merge a 20-patch series late in the cycle when we already
have 100 patches from the same maintainer than for the case where haven't seen
anything for that platform at all.

	Arnd
