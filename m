From: ao2@ao2.it (Antonio Ospite)
Date: Thu, 28 Jan 2016 10:58:24 +0100
Subject: [PATCH] ARM: lib/lib1funcs.S: fix typo
 s/substractions/subtractions/
In-Reply-To: <20160127192711.GE10826@n2100.arm.linux.org.uk>
References: <1453902670-32294-1-git-send-email-ao2@ao2.it>
 <20160127192711.GE10826@n2100.arm.linux.org.uk>
Message-ID: <20160128105824.d04860f1b98afcdca46a29c0@ao2.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jan 2016 19:27:12 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Wed, Jan 27, 2016 at 02:51:10PM +0100, Antonio Ospite wrote:
> > While at it also fix some other typos in the affected lines:
> >   s/reminder/remainder/
> >   s/comparison/comparisons/
> > 
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> 
> Acked-by: Russell King <rmk+kernel@Arm.linux.org.uk>
> 
> Thanks.  I assume the trivial tree will be picking this up?

Hi Russel, can't you pick it up in the ARM tree?

I had sent this change to the trivial tree last April, and you ACKed it
back then as well, but it was not merged. Maybe Jiri, who maintains the
trivial tree, thought that you were picking it up.

I have been told, by Mark Brown IIRC, that (I'm paraphrasing) subsystem
maintainers should be the preferred recipients, and that "all-over"
maintainers are only for when the same change applies to multiple
subsystems and it does not make sense to split the patch.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
