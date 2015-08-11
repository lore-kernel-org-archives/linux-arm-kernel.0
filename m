From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 11 Aug 2015 23:25:23 +0100
Subject: [PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and GICv3 support
In-Reply-To: <55CA70D5.6040300@codeaurora.org>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
 <55CA70D5.6040300@codeaurora.org>
Message-ID: <20150811232523.60d192d2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Aug 2015 23:01:57 +0100
Timur Tabi <timur@codeaurora.org> wrote:

> On 07/29/2015 05:08 AM, Hanjun Guo wrote:
> > Patches are on top of Marc's branch irq/gsi-irq-domain-v2, and available
> > at:
> >
> > git://git.linaro.org/leg/acpi/acpi.git gsi-irqdomain
> 
> Is it my imagination, or is Marc's branch based on v3.9-rc7?

That's definitely your imagination. I've stopped working on 3.9 over
two years ago...

> Also, shouldn't this code be based on the upstream kernel, and not the 
> LEG kernel?

My branch, as far as I can tell by looking at my own git tree, is based
on v4.2-rc2. As for "the LEG kernel", I have no idea what that is. I
only work on this thing called "the Linux kernel". You may have heard
of it! ;-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
