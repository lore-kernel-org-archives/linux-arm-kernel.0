From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Mar 2014 21:09:45 +0000
Subject: [PATCH 58/75] ARM: l2c: omap2: remove cache size override
In-Reply-To: <20140328160358.GG24308@atomide.com>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYZ1-0007Gn-3J@rmk-PC.arm.linux.org.uk>
 <20140328160358.GG24308@atomide.com>
Message-ID: <20140328210945.GU7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 09:03:59AM -0700, Tony Lindgren wrote:
> * Russell King <rmk+kernel@arm.linux.org.uk> [140328 08:22]:
> 
> Missing description?

No, I just got sick and tired of trying to write descriptions for these
patches.  Many of these I regard as totally unnecessary patches that
should never have been required had platform folk not invested in
cargo cult programming.

Given the number of patches I'm presently dealing with in my tree right
now, I don't actually have time to even follow the mailing lists at the
moment.  If I were to properly describe all of these patches, I'd
probably be at this for another few weeks.

So, I'm at the point of "what you see is what you've got" as far as the
descriptions go... it's going to cause me a /lot/ of pain to just add
all the acks I'm going to need to these patches.

And... don't expect me to send the series out again any time soon to
LAKML - it's taken four to five hours for all these patches to filter
through the lists.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
