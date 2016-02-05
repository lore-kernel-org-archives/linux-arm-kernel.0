From: contact@paulk.fr (Paul Kocialkowski)
Date: Fri, 05 Feb 2016 19:48:10 +0100
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <20160118163248.GI6588@sirena.org.uk>
References: <5681D7A8.2030101@ti.com> <1451387613.18148.9.camel@collins>
 <568323B7.7080101@ti.com> <1451464521.2531.4.camel@collins>
 <20151230163307.GW16023@sirena.org.uk> <1451500639.14341.6.camel@collins>
 <20151231214007.GC16023@sirena.org.uk> <1451599146.9673.2.camel@collins>
 <20151231221407.GF16023@sirena.org.uk> <1452929533.2520.1.camel@collins>
 <20160118163248.GI6588@sirena.org.uk>
Message-ID: <1454698090.2623.3.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le lundi 18 janvier 2016 ? 16:32 +0000, Mark Brown a ?crit :
> On Sat, Jan 16, 2016 at 08:32:13AM +0100, Paul Kocialkowski wrote:
> 
> > Is there some git tree I can work with that has regulator runtime PM
> > support at this point? I'll certainly end up handling the GPIO in the
> > driver otherwise.
> 
> No, the last week was much more busy than I was expecting.  I'm hoping
> for this week (or you could have a go at implementing it, it'd be adding
> the PM operations in _regulator_enable() or _regulator_do_enable() if a
> flag was set in the regulator_desc).

I decided to go with a function simply requesting the GPIO for v2.
Support for runtime PM can be added later. I'll get back to you on this
on the thread related to your patches, since it appears to be somewhat
broken for now.

Thanks!
-- 
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160205/b35e9556/attachment.sig>
