From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 26 Jun 2012 13:25:02 +1000
Subject: linux-next: adding the common clk tree
In-Reply-To: <20120626015551.GW4402@gmail.com>
References: <20120626015551.GW4402@gmail.com>
Message-ID: <20120626132502.7584f6acbfc23bdc3d6a8f8e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Mon, 25 Jun 2012 18:55:51 -0700 Mike Turquette <mturquette@ti.com> wrote:
>
> Would you please add the clk-next branch of the common clock tree to
> linux-next?
> 
> git://git.linaro.org/people/mturquette/linux.git clk-next
> 
> Thanks much!
> 
> For all of those Cc'd, I just wanted to say that I'm changing the way I
> manage clk-next.  The clk-next branch now WILL be rebased, and it's only
> purpose is to make it easy to test things in linux-next.  You can base
> work on it, but be prepare for breakage and shifting commit ids.
> 
> If you don't want breakage and shifting commit ids then you might want
> to use my clk-fixes branch (stable) and my clk-3.x branch (stable).  As
> patches go through the linux-next cycle and appear stable I'll migrate
> them over to clk-3.x which won't ever be rebased.  This is the branch
> I'll send to Linus.  clk-next is simply comprised of merging clk-fixes,
> clk-3.x and whatever unstable patches I have laying around.

Maybe you have misunderstood the point of linux-next (is is an
integration testing tree, not a development tree)?  I am wondering if, in
particular, the clk-3.x branch (or something near that) may be more
appropriate for linux-next inclusion (and maybe the clk-fixes branch in
my "fixes to the current release" section)?

This is what I tell everyone:

You will need to ensure that the commits in your tree have been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell	sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120626/6d37a3af/attachment.sig>
