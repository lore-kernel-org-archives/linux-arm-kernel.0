From: broonie@kernel.org (Mark Brown)
Date: Fri, 16 Jan 2015 16:54:22 +0000
Subject: [PATCH v7 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <20150116122922.GO7091@arm.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <CACxGe6v_BvCQqp8d=LaQ8HeaOU1Zh_HPpwFTdwOjHUbqXsnQ8g@mail.gmail.com>
 <20150115182346.GE2329@e104818-lin.cambridge.arm.com>
 <20150115190220.GF3043@sirena.org.uk>
 <20150115200437.GF24989@titan.lakedaemon.net>
 <20150116101034.GC13634@e104818-lin.cambridge.arm.com>
 <20150116120518.GK3043@sirena.org.uk>
 <20150116122922.GO7091@arm.com>
Message-ID: <20150116165422.GE3856@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 12:29:22PM +0000, Will Deacon wrote:
> On Fri, Jan 16, 2015 at 12:05:18PM +0000, Mark Brown wrote:

> > Actually, another thing that might help would be if you and/or Will were
> > to prod the relevant people for review, letting them know that the
> > controversy isn't likely to affect their bits.

> Hmm, we *could*, but having maintainers go round poking other people to
> review patches feels like the wrong way round to me. The authors should
> be taking ownership of this series and that's half of the problem we
> had in previous versions.

> It needs to be clear that Hanjun/Al/Graeme are the ones running the show,
> not just now, but (even more importantly) when people start building on
> top of the base support. If Catalin and I have to go around asking for
> review, it sets us off on the wrong foot imo.

That's true in general but equally right now it's also fairly clear that
this isn't going anywhere immediately (and one might assume potentially
may end up needing substantial rework) for arm64 related reasons which
creates a bit of stop energy that's more easily unblocked by the arm64
maintainers than others.  From that point of view I guess just giving
the ACPI folks something to point at to indicate that the remaining
issues on the architecture side aren't likely to affect the relevant
code would probably help also.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150116/5f375ae2/attachment.sig>
