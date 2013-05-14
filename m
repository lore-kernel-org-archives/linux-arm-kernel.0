From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 May 2013 10:32:49 +0200
Subject: [PATCH 08/14] ARM: msm: Remove init_irq declaration in machine
 description
In-Reply-To: <20130513182648.GA26913@codeaurora.org>
References: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368438253-28218-9-git-send-email-maxime.ripard@free-electrons.com>
 <20130513182648.GA26913@codeaurora.org>
Message-ID: <5191F6B1.9080000@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Le 13/05/2013 20:26, David Brown a ?crit :
> On Mon, May 13, 2013 at 11:44:07AM +0200, Maxime Ripard wrote:
>> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
>> specified") removed the need to explictly setup the init_irq field in
>> the machine description when using only irqchip_init. Remove that
>> declaration for msm as well.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  arch/arm/mach-msm/board-dt-8660.c | 1 -
>>  arch/arm/mach-msm/board-dt-8960.c | 1 -
>>  2 files changed, 2 deletions(-)
> 
> I'll pull this into my msm-cleanup tree.

Like I said in other mails from this thread, I'll send a v2, so you
might want to hold off this patch until then.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
