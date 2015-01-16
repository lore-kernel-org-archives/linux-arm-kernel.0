From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 Jan 2015 12:29:22 +0000
Subject: [PATCH v7 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <20150116120518.GK3043@sirena.org.uk>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <CACxGe6v_BvCQqp8d=LaQ8HeaOU1Zh_HPpwFTdwOjHUbqXsnQ8g@mail.gmail.com>
 <20150115182346.GE2329@e104818-lin.cambridge.arm.com>
 <20150115190220.GF3043@sirena.org.uk>
 <20150115200437.GF24989@titan.lakedaemon.net>
 <20150116101034.GC13634@e104818-lin.cambridge.arm.com>
 <20150116120518.GK3043@sirena.org.uk>
Message-ID: <20150116122922.GO7091@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 12:05:18PM +0000, Mark Brown wrote:
> On Fri, Jan 16, 2015 at 10:10:34AM +0000, Catalin Marinas wrote:
> 
> > Indeed, keeping the series as one thread is better. Apart from a
> > slightly less misleading subject, I suggest Hanjun that he passes each
> > patch via get_maintainer.pl and adds the corresponding Cc: lines to the
> > commit log. I think that's a clearer way keep track of who needs to
> > ack/review the patches.
> 
> I'm not saying stop sending them as part of this series, I'm saying it
> might help to get people to look at them if they were also sent
> disassociated from it - in the situations where I end up ignoring things
> that look controversial but unexciting for my bit of it I know I won't
> even bother opening the e-mails since I know it's just going to get
> resent anyway quite often with revisions from whatever makes the rest of
> the series controversial, I expect others will do the same.
> 
> Actually, another thing that might help would be if you and/or Will were
> to prod the relevant people for review, letting them know that the
> controversy isn't likely to affect their bits.

Hmm, we *could*, but having maintainers go round poking other people to
review patches feels like the wrong way round to me. The authors should
be taking ownership of this series and that's half of the problem we
had in previous versions.

It needs to be clear that Hanjun/Al/Graeme are the ones running the show,
not just now, but (even more importantly) when people start building on
top of the base support. If Catalin and I have to go around asking for
review, it sets us off on the wrong foot imo.

Will
