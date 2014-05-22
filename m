From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 May 2014 19:30:54 +0100
Subject: [PATCH v3 5/9] ASoC: simple-card: Support setting mclk via a
 fixed factor
In-Reply-To: <20140522175206.GA24500@lunn.ch>
References: <20140520221359.GF12304@sirena.org.uk>
 <1400772710-23523-1-git-send-email-andrew@lunn.ch>
 <20140522173919.GM12304@sirena.org.uk>
 <20140522175206.GA24500@lunn.ch>
Message-ID: <20140522183054.GQ12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 07:52:06PM +0200, Andrew Lunn wrote:
> On Thu, May 22, 2014 at 06:39:19PM +0100, Mark Brown wrote:

> > I'm missing the rest of this series - what's the context, are there any
> > interdependencies?

> I threaded the patch to your request to respin this patch:

> http://patchwork.ozlabs.org/patch/345353/

Ugh, no - don't do this.  It's just confusing.  Patch series numbering
is used for ordering within a posting of a patch series, the fact that
a given patch might have previously been posted along with some others
isn't relevant if you send it out again in a different form.  People
will hopefully expect to see the rest of the series so they can check
for interdependencies and so on, if the subject says there are 9 patches
in what you're posting then there should be 9 patches.

Similarly threading individual modifications to patches into the middle
of prior postings makes it hard to track what's going on if things
aren't applied - "I want version 1 of this patch, version 2 of that one"
and so on gets hard to follow especially if there's a thread around them.
You get problems like some revisions getting missed in the middle of the
thread.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140522/a0b1cbaa/attachment-0001.sig>
