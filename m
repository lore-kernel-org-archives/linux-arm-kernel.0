From: martin.jansa@gmail.com (Martin Jansa)
Date: Fri, 8 Apr 2011 10:28:27 +0200
Subject: [Zaurus-devel] 2.6.39-rc2 on zaurus: does not build, does not boot
In-Reply-To: <201104080931.11202.marek.vasut@gmail.com>
References: <20110408062646.GA1472@ucw.cz>
	<201104080931.11202.marek.vasut@gmail.com>
Message-ID: <20110408082827.GD3180@jama.jama.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 08, 2011 at 09:31:10AM +0200, Marek Vasut wrote:
> On Friday 08 April 2011 08:26:46 Pavel Machek wrote:
> > Hi!
> > 
> > Build fix is below. Maybe it is pending in the trees somewhere
> > already...
> 
> Fix is already there, it was broken by a patch from someone recently. Thanks 
> though
> > 
> > Boot stops just after mounting root filesystem; cursor stops
> > flashing. (Any idea what goes on there?)
> 
> No idea, it works for me and doesn't hang ;-)

it works here too with rev 6221f222c0ebf1acdf7abcf927178f40e1a65e2a

Cheers,

-- 
Martin 'JaMa' Jansa     jabber: Martin.Jansa at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110408/90563cf7/attachment.sig>
