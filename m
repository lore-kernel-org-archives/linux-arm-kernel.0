From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Jan 2015 19:02:20 +0000
Subject: [PATCH v7 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <20150115182346.GE2329@e104818-lin.cambridge.arm.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <CACxGe6v_BvCQqp8d=LaQ8HeaOU1Zh_HPpwFTdwOjHUbqXsnQ8g@mail.gmail.com>
 <20150115182346.GE2329@e104818-lin.cambridge.arm.com>
Message-ID: <20150115190220.GF3043@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 06:23:47PM +0000, Catalin Marinas wrote:
> On Thu, Jan 15, 2015 at 04:26:20PM +0000, Grant Likely wrote:

> > I'll get right to the point: Can we please have this series queued up
> > for v3.20?

> Before you even ask for this, please look at the patches and realise
> that there is a complete lack of Reviewed-by tags on the code (well,
> apart from trivial Kconfig changes). In addition, the series touches on
> other subsystems like clocksource, irqchip, acpi and I don't see any
> acks from the corresponding maintainers. So even if I wanted to merge
> the series, there is no way it can be done without additional
> reviews/acks. On the document (last patch), I'd like to see a statement

There's probably a bit of a process problem here - these patches are all
being posted as part of big and apparently controversial threads with
subject lines in the form "ARM / ACPI:" so people could be forgiven for
just not even reading the e-mails enough to notice changes to their
subsystems.  Is it worth posting those patches separately more directly
to the relevant maintainers?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/45669d98/attachment.sig>
