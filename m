From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 2 Apr 2013 10:24:46 +0100
Subject: [PATCH] ARM: ux500: update V-INTCORE constraints
In-Reply-To: <20130402084446.GA6850@balto.lan>
References: <1364397694-14126-1-git-send-email-fabio.baltieri@linaro.org>
 <CACRpkdYgCxf9R1aU2QdPUBxErhK=E2tM=6L-yMLA_L3+ntj3nQ@mail.gmail.com>
 <20130402083829.GB23065@opensource.wolfsonmicro.com>
 <20130402084446.GA6850@balto.lan>
Message-ID: <20130402092446.GB4375@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > I know that Lee's been sending off a large set of regulator patches
> > > lately, some include alterations to this platform config.
> > 
> > > Maybe it's better to take this patch into the regulator tree if these
> > > machine configs will come in that way? Also like Lee to have a
> > > look at this...
> > 
> > If it's touching the board constraints it's likely to have conflicts
> > with Lee's stuff, yes.
> 
> Lee's patches are on -next

Not all of them are on -next, but all are on the MLs.

I'm currently fixing up some of Mark's review comments in order to
re-submit the remainder.

> and should not conflict with this one
> (tested again on today's tree), but it may be nice anyway to have this
> in the regulator framework with the others.

> Mark, would you consider taking this one in your tree?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
