From: joe@perches.com (Joe Perches)
Date: Wed, 28 Oct 2015 10:18:16 -0700
Subject: [PATCH] get_maintainer: Add subsystem to reviewer output
In-Reply-To: <20151028170116.GI4058@x1>
References: <20151027172428.GB21070@earth> <20151027181555.GE5828@x1>
 <1445971482.2757.27.camel@perches.com>
 <CAJKOXPc_w2Dc8LvkCu_d+kjZZmYScXboQrpNWdicT2yfL_5D7Q@mail.gmail.com>
 <20151028082446.GF5828@x1> <56309419.4060908@samsung.com>
 <20151028093907.GP4931@pengutronix.de> <20151028095524.GP5828@x1>
 <5630CA06.7050503@samsung.com> <1446050506.2757.109.camel@perches.com>
 <20151028170116.GI4058@x1>
Message-ID: <1446052696.2757.128.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-10-28 at 17:01 +0000, Lee Jones wrote:
> It looks like I'm going to have to drop the patch where we actually
> start using the R: tag properly due to some social, emotional issues.

btw: it seems to me the thing you're looking for is the tree
to which any particular patch could or would be applied.

That can be got by using the --scm option:

	./scripts/get_maintainer.pl --scm <patch>

Only ~400 of ~1445 subsystem sections have a "T:" tree entry
so pairing the maintainer and the tree generally tells you
who is responsible for upstreaming any patch.
