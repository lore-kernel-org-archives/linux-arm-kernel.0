From: david@gibson.dropbear.id.au (David Gibson)
Date: Wed, 2 Oct 2013 23:52:21 +1000
Subject: [RFC 00/15] Device Tree schemas and validation
In-Reply-To: <524ACB76.1010001@gmail.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
 <524A8289.3050107@baylibre.com> <524ACB76.1010001@gmail.com>
Message-ID: <20131002135220.GG6506@voom.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 08:17:42AM -0500, Rob Herring wrote:
> On 10/01/2013 03:06 AM, Benoit Cousson wrote:
> > + more DT maintainers folks
> > 
> > Hi all,
> > 
> > I know this is mostly boring user space code, but I was expecting a
> > little bit of comments about at least the bindings syntax:-(
> > 
> > I'd like to know if this is the right direction and if it worth pursuing
> > in that direction.
> > 
> > The idea was to have at least some base for further discussion during
> > ARM KS 2013.
> > 
> > I feel alone :-(
> > 
> > If you have any comment, go ahead!
> 
> Thanks for taking this on!
> 
> This is interesting approach using the dts syntax, but I worry that the
> validation will only be as good as the schema written and the review of
> the schema. I think the schema needs to define the binding rather than
> define the checks. Then the schema can feed the validation checks. This
> format does not seem to me as easily being able to generate
> documentation from the schema which I believe is one of the goals. I for
> one don't care to review the documentation and the schema for every binding.

Hrm.  I'm less optimistic about entirely replacing human-readable
bindings with machine-readable schemas.  But I do think the schema
language needs to be substantially more flexible than the draft
presented here.

While I think a schema syntax which mirrors dts syntax makes a lot of
sense, actually defining schemas as "device" trees doesn't seem quite
right to me.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131002/83f7e873/attachment.sig>
