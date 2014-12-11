From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Dec 2014 18:03:04 +0100
Subject: [PATCH v5 00/61] dmaengine: Implement generic slave capabilities
 retrieval
In-Reply-To: <54861D04.8000102@metafoo.de>
References: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
 <20141208061746.GD16827@intel.com> <20141208141807.GC8739@lukather>
 <20141208162843.GP16827@intel.com> <20141208183853.GG8739@lukather>
 <54861D04.8000102@metafoo.de>
Message-ID: <20141211170304.GG8739@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 10:49:56PM +0100, Lars-Peter Clausen wrote:
> On 12/08/2014 07:38 PM, Maxime Ripard wrote:
> [...]
> >>And lastly noone blamed you for being late, if things were rosy they
> >>would have been merged over the weekend and been in today's next,
> >>but...
> >
> >I totally understand your point. And I actually am a bit uncomfortable
> >merging this so late too, and I'd actually prefer to have it merged
> >for 3.20. But this is a huge patchset, and I'd really like to avoid
> >rebasing it forever.
> 
> We don't have to pull in the whole series at once. I think everybody agrees
> that the approach is the right one, so the first couple of patches that work
> on the framework should be good to go in. Same goes for the drivers that
> have been acked and tested.

I'm a bit skeptical that it is the right approach. These patches have
been here for monthes, and even you failed to ack and test these
patches on the drivers you wrote. As a matter of fact, only Laurent,
Linus, Ludovic and Stephen looked at their respective changes. After 3
monthes and 6 versions.

At some point, cleanups have to come in.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141211/08971499/attachment.sig>
