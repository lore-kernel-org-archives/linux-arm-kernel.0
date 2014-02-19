From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 19 Feb 2014 13:01:33 -0500
Subject: [GIT PULL] ARM: mvebu: DT fixes for v3.14
In-Reply-To: <CAOesGMjwgGKRPA_nDrBzf+z-hvswuGrZE2TQUqXeWR6HijRQuA@mail.gmail.com>
References: <20140218161102.GT7862@titan.lakedaemon.net>
 <20140219002446.GD25055@quad.lixom.net>
 <20140219154341.GK7862@titan.lakedaemon.net>
 <CAOesGMjwgGKRPA_nDrBzf+z-hvswuGrZE2TQUqXeWR6HijRQuA@mail.gmail.com>
Message-ID: <20140219180133.GL7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 08:25:15AM -0800, Olof Johansson wrote:
> On Wed, Feb 19, 2014 at 7:43 AM, Jason Cooper <jason@lakedaemon.net> wrote:
...
> > At any rate, it does remove the warning for v3.14, and the driver is
> > slated for v3.15, So I'll re-add the node for v3.15.
> >
> > Unfortunately, this creates a dependency on mvebu/dt-fixes by mvebu/dt.
> > Or, I could just add the node to fixes-non-critical for v3.15 to avoid
> > the dependency.  Which do you prefer?
> 
> Just base mvebu/dt on top of dt-fixes, alternatively merge dt-fixes
> into dt before you have to apply the conflicting patches -- that
> should take care of it. Or am I missing something here?

Nope, I've just gotten really good at avoiding dependencies if I can. :)

thx,

Jason.
