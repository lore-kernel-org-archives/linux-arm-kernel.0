From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 15 Jan 2015 15:51:39 -0500
Subject: [PATCH v7 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <20150115203159.GG3043@sirena.org.uk>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <CACxGe6v_BvCQqp8d=LaQ8HeaOU1Zh_HPpwFTdwOjHUbqXsnQ8g@mail.gmail.com>
 <20150115182346.GE2329@e104818-lin.cambridge.arm.com>
 <20150115190220.GF3043@sirena.org.uk>
 <20150115200437.GF24989@titan.lakedaemon.net>
 <20150115203159.GG3043@sirena.org.uk>
Message-ID: <20150115205139.GG24989@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 08:31:59PM +0000, Mark Brown wrote:
> On Thu, Jan 15, 2015 at 03:04:37PM -0500, Jason Cooper wrote:
> > On Thu, Jan 15, 2015 at 07:02:20PM +0000, Mark Brown wrote:
> 
> > > There's probably a bit of a process problem here - these patches are all
> > > being posted as part of big and apparently controversial threads with
> > > subject lines in the form "ARM / ACPI:" so people could be forgiven for
> > > just not even reading the e-mails enough to notice changes to their
> > > subsystems.  Is it worth posting those patches separately more directly
> > > to the relevant maintainers?
> 
> > I think it's beneficial to post the entire series as one thread, but to
> > change the subject line of each patch to adequately reflect the affected
> > subsystem.
> 
> Just changing the subject lines to be more suitable would help, but
> given the painful thread it's probably worth going the extra step if
> the lack of these reviews is a causing problems - I know that even with
> a suitable subject line if I'm busy then I'm fairly likely to zone out
> something in the middle a big series that doesn't seem to be going
> anywhere.

True, I was merely expressing a preference.  A lot of series containing
irqchip changes tend to have build dependencies outside of
drivers/irqchip. So I like to see the whole picture to decide how best
to handle the patches.

I suppose the ideal solution would be to have a "mute sub-thread" option
in the MUA.  But that doesn't help us today.  :)

Whichever way they do it is fine by me.

thx,

Jason.
