From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 11 Aug 2015 23:48:01 +0100
Subject: [PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and GICv3 support
In-Reply-To: <55CA78DE.1000306@codeaurora.org>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
 <55CA70D5.6040300@codeaurora.org> <20150811232523.60d192d2@arm.com>
 <55CA78DE.1000306@codeaurora.org>
Message-ID: <20150811234801.51108784@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Aug 2015 23:36:14 +0100
Timur Tabi <timur@codeaurora.org> wrote:

> On 08/11/2015 05:25 PM, Marc Zyngier wrote:
> > My branch, as far as I can tell by looking at my own git tree, is based
> > on v4.2-rc2. As for "the LEG kernel", I have no idea what that is. I
> > only work on this thing called "the Linux kernel". You may have heard
> > of it!;-)
> 
> Then what is this:
> 
> git://git.linaro.org/leg/acpi/acpi.git
>                       ^^^
> 
> This is your tree, isn't it?  

My tree would have "maz" in it, and would rather be hosted on
kernel.org.

> Hanjun said, "Patches are on top of Marc's 
> branch irq/gsi-irq-domain-v2, and available at: 
> git://git.linaro.org/leg/acpi/acpi.git gsi-irqdomain".

I don't see any contradiction here. Hanjun picked the patches from my
own branch in my own tree, put his own patches on top, and pushed that
out on an branch called gsi-irqdomain that is definitely based on
4.2-rc2. I have no idea where your 3.9-rc7 comes from.

	M.
-- 
Jazz is not dead. It just smells funny.
