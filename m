From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 6 Oct 2010 08:58:34 -0600
Subject: [PATCH 00/08] ARM: Dynamic IRQ demux support
In-Reply-To: <AANLkTi=So8SAY+TRRP1xjxzoYGxZjk0PzLHDhR_qKGUc@mail.gmail.com>
References: <20101006071731.28048.89938.sendpatchset@t400s>
	<AANLkTi=So8SAY+TRRP1xjxzoYGxZjk0PzLHDhR_qKGUc@mail.gmail.com>
Message-ID: <AANLkTinm+bJduJ+46eUb8TA_v644Ui6j+zeBUKegofY7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 6, 2010 at 7:06 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Wed, Oct 6, 2010 at 3:17 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> ARM: Dynamic IRQ demux support
>>
>> [PATCH 01/08] ARM: Move entry-header.S to asm/
>> [PATCH 02/08] ARM: Move macros from entry-armv.S
>> [PATCH 03/08] ARM: Make alignment_trap macro self-contained
>> [PATCH 04/08] ARM: Convert __irq_svc and __usr_svc to macros
>> [PATCH 05/08] ARM: Move the unwind header to entry-header.S
>> [PATCH 06/08] ARM: Add setup_irq_stubs() function
>> [PATCH 07/08] ARM: Add CONFIG_DEFAULT_IRQ_DEMUX
>> [PATCH 08/08] ARM: Dynamic IRQ demux for SH-Mobile
>>
>
> Hi Magnus,
>
> Just FYI, I had a patch months ago for this:
>
> http://www.spinics.net/linux/lists/arm-kernel/msg92836.html
>
> Do you think that's a simpler way to go?

Speaking of which, what is the status of your patch?  I see you
reposted it on July 13, but I haven't seen any further feedback.

g.
