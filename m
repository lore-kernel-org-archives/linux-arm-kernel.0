From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 10 Dec 2013 23:56:32 +0000 (UTC)
Subject: [GIT PULL] make mach-omap2 boot with device tree only for
 v3.14
In-Reply-To: <20131210185902.GO13171@atomide.com>
References: <pull-1386643347-596413>
 <alpine.DEB.2.02.1312101034360.32309@utopia.booyaka.com>
 <20131210185902.GO13171@atomide.com>
Message-ID: <alpine.DEB.2.02.1312102353170.20154@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Dec 2013, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [131210 10:47]:
>
> > - The N800 isn't booting here with a concatenated uImage+dtb - but
> >   maybe I'm doing something wrong with this one.
> 
> Hmm n800 works for me here for sure, I can n-uple check today.

The N800 here is booting now with this series.  My mistake, as 
suspected...

> > Best if the pull request were to explicitly state the known 
> > regressions with this series, in terms of specific boards and 
> > configurations.  That way, people will know what to expect.
> 
> Well ideally we would have no regressions when doing this, but I've
> been chasing people and bugs for few years now on this DT conversion
> and we still always find something. In most cases it should be just
> a question of configuring a board specific .dts file. I don't have
> all the boards though, so I've only done the ones I have naturally.

Yeah some level of regression is expected with this, for sure.  It's just 
good to have it documented if it's known.


- Paul
