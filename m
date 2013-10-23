From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 22:05:00 +0200
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <20131023193959.GA6777@katana>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <5267FA58.9050002@wwwdotorg.org> <20131023172001.GA3379@katana>
 <20131023185909.GC7863@ulmo.nvidia.com>
 <20131023193959.GA6777@katana>
Message-ID: <20131023200459.GB8828@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 08:40:00PM +0100, Wolfram Sang wrote:
> 
> > > I'd even go further and use "unstable-" as the prefix instead of "!"
> > > which is way more explicit.
> > 
> > I guess unstable- is as good as anything. I personally think that "!" is
> > disturbing enough to the eye to make it abundantly clear that something
> > is fishy.
> 
> "!" marks the binding as "special" whatever that is. A busy person might
> decide to not look that up as long as it works right now. "unstable-"
> (or maybe "unstable!-" ;)) is explicit so people know what they get.

We'll need to document this somewhere to make people aware of it. And if
nobody bothers to read that documentation then they're not entitled to
complain.

That said, in my experience people are just as likely to ignore anything
with an "unstable" in it until it breaks. Also I don't think "unstable"
is the right term. "unstable" implies that it somehow influences the
system stability. But that's not the case. "experimental" is much more
accurate in that developers are experimenting with the representation.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/8afc1362/attachment.sig>
