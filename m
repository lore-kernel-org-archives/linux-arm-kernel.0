From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Tue, 2 Apr 2013 10:44:46 +0200
Subject: [PATCH] ARM: ux500: update V-INTCORE constraints
In-Reply-To: <20130402083829.GB23065@opensource.wolfsonmicro.com>
References: <1364397694-14126-1-git-send-email-fabio.baltieri@linaro.org>
 <CACRpkdYgCxf9R1aU2QdPUBxErhK=E2tM=6L-yMLA_L3+ntj3nQ@mail.gmail.com>
 <20130402083829.GB23065@opensource.wolfsonmicro.com>
Message-ID: <20130402084446.GA6850@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, Linus,

On Tue, Apr 02, 2013 at 09:38:30AM +0100, Mark Brown wrote:
> On Tue, Apr 02, 2013 at 10:26:12AM +0200, Linus Walleij wrote:
> 
> > I know that Lee's been sending off a large set of regulator patches
> > lately, some include alterations to this platform config.
> 
> > Maybe it's better to take this patch into the regulator tree if these
> > machine configs will come in that way? Also like Lee to have a
> > look at this...
> 
> If it's touching the board constraints it's likely to have conflicts
> with Lee's stuff, yes.

Lee's patches are on -next and should not conflict with this one
(tested again on today's tree), but it may be nice anyway to have this
in the regulator framework with the others.

Mark, would you consider taking this one in your tree?

Thanks,
Fabio

-- 
Fabio Baltieri
