From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 25 Feb 2014 19:09:40 -0500
Subject: [PATCH 00/10] pinctrl: mvebu: remove hard-coded addresses from
 Dove pinctrl
In-Reply-To: <CACRpkdZ+YGTyDj6i8c198MdRtz3GY-YBmVO9LysPCcmT4EC0cg@mail.gmail.com>
References: <1393231382-11078-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140224181023.GA1010@titan.lakedaemon.net>
 <CACRpkdZ+YGTyDj6i8c198MdRtz3GY-YBmVO9LysPCcmT4EC0cg@mail.gmail.com>
Message-ID: <20140226000940.GF1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Tue, Feb 25, 2014 at 10:36:54AM +0100, Linus Walleij wrote:
> On Mon, Feb 24, 2014 at 7:10 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> 
> > Sebastian, Linus,
> >
> > I've now created mvebu/pinctrl-dove for this series.  It's based on
> > v3.14-rc1, and depends on mvebu/pinctrl (which depends on
> > mvebu/pinctrl-3xx).
> >
> > I've kept this series in a separate branch in case we encounter an
> > unforeseen problem with something in here.  Then this branch can be
> > dropped, and /pinctrl-3xx and /pinctrl will still make it in.
> >
> > So, all patches except 3 and 4 are in mvebu/pinctrl-dove.  3 and 4 are
> > in mvebu/dt.
> 
> OK so what should I be pulling in first now?

Sebastian has now re-organized the branches as I asked, and I confirmed
that the final result is the exact same as mine (diff is null).

Usually when I submit pull requests to arm-soc, they like to see the
branches.  That way if there is an error in one of them, they just drop
the one branch and the others remain.

Would you like them the same way?  If so, I'll send the pulls to you
tomorrow.  Otherwise, I'll wait a few more days to let things shake out
and then send you one request with the branches merged.

thx,

Jason.
