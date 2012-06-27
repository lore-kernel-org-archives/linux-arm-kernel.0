From: mturquette@ti.com (Mike Turquette)
Date: Wed, 27 Jun 2012 10:50:37 -0700
Subject: linux-next: adding the common clk tree
In-Reply-To: <20120628002925.dd144b4782398042593b6b47@canb.auug.org.au>
References: <20120626015551.GW4402@gmail.com>
 <20120626132502.7584f6acbfc23bdc3d6a8f8e@canb.auug.org.au>
 <20120626230503.GA4402@gmail.com>
 <20120628002925.dd144b4782398042593b6b47@canb.auug.org.au>
Message-ID: <20120627175037.GF22766@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120628-00:29, Stephen Rothwell wrote:
> Hi Mike,
> 
> On Tue, 26 Jun 2012 16:05:03 -0700 Mike Turquette <mturquette@ti.com> wrote:
> >
> > So please let me know if I still have the concept wrong and I'll change
> > things up.  Otherwise my clk-next fulfils all of the guidelines you've
> > mentioned below for inclusion into linux-next.
> 
> OK, that all seems to be fine.  I would make one suggestion: that you
> create the clk-next branch like this:
> 
> git checkout clk-next
> git reset --hard clk-3.x
> git merge clk-fixes
> git am patches/clk/next/incoming/*.patch
> 
> or maybe just merge clk-fixes directly into clk-3.x when necessary or
> from time to time and base clk-next just in clk-3.x.

Using clk-3.x as a base for clk-next sounds fine to me.  I'll use the
approach you outlined above.

Thanks much,
Mike

> --
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
