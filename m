From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Jan 2015 10:10:34 +0000
Subject: [PATCH v7 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <20150115200437.GF24989@titan.lakedaemon.net>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <CACxGe6v_BvCQqp8d=LaQ8HeaOU1Zh_HPpwFTdwOjHUbqXsnQ8g@mail.gmail.com>
 <20150115182346.GE2329@e104818-lin.cambridge.arm.com>
 <20150115190220.GF3043@sirena.org.uk>
 <20150115200437.GF24989@titan.lakedaemon.net>
Message-ID: <20150116101034.GC13634@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 08:04:37PM +0000, Jason Cooper wrote:
> On Thu, Jan 15, 2015 at 07:02:20PM +0000, Mark Brown wrote:
> > On Thu, Jan 15, 2015 at 06:23:47PM +0000, Catalin Marinas wrote:
> > > On Thu, Jan 15, 2015 at 04:26:20PM +0000, Grant Likely wrote:
> > 
> > > > I'll get right to the point: Can we please have this series queued up
> > > > for v3.20?
> > 
> > > Before you even ask for this, please look at the patches and realise
> > > that there is a complete lack of Reviewed-by tags on the code (well,
> > > apart from trivial Kconfig changes). In addition, the series touches on
> > > other subsystems like clocksource, irqchip, acpi and I don't see any
> > > acks from the corresponding maintainers. So even if I wanted to merge
> > > the series, there is no way it can be done without additional
> > > reviews/acks. On the document (last patch), I'd like to see a statement
> > 
> > There's probably a bit of a process problem here - these patches are all
> > being posted as part of big and apparently controversial threads with
> > subject lines in the form "ARM / ACPI:" so people could be forgiven for
> > just not even reading the e-mails enough to notice changes to their
> > subsystems.  Is it worth posting those patches separately more directly
> > to the relevant maintainers?
> 
> I think it's beneficial to post the entire series as one thread, but to
> change the subject line of each patch to adequately reflect the affected
> subsystem.

Indeed, keeping the series as one thread is better. Apart from a
slightly less misleading subject, I suggest Hanjun that he passes each
patch via get_maintainer.pl and adds the corresponding Cc: lines to the
commit log. I think that's a clearer way keep track of who needs to
ack/review the patches.

-- 
Catalin
