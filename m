From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Sat, 9 Jan 2010 13:47:31 +1100
Subject: [GIT PULL] omap fixes for 2.6.33-rc3
In-Reply-To: <20100108225023.GD2879@atomide.com>
References: <20100108180912.GC6831@atomide.com>
	<alpine.LFD.2.00.1001081014090.7821@localhost.localdomain>
	<20100108182236.GE6831@atomide.com>
	<alpine.DEB.2.00.1001081502480.19243@utopia.booyaka.com>
	<20100108222715.GC2879@atomide.com>
	<alpine.LFD.2.00.1001081430210.7821@localhost.localdomain>
	<20100108225023.GD2879@atomide.com>
Message-ID: <20100109134731.a1bca240.sfr@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Fri, 8 Jan 2010 14:50:23 -0800 Tony Lindgren <tony@atomide.com> wrote:
>
> Hmm, sounds like it might make sense to check for that in Stephen's
> for-next tree then. Added Stephen to the loop, let's see if what he
> thinks.

I can certainly add hooks to my tree if someone can suggest what should
be in them (I didn't get enough context here ...).  That way I could send
the tree maintainer a warning email letting them know something is
fishy ...

Of course, this only helps those who don't mind rebasing their trees,
right?  The non-rebasing tree maintainers should do these checks
themselves.  Maybe we could propogate a suggested (or mandatory) set of
hooks?

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100109/a58dc3e4/attachment.sig>
