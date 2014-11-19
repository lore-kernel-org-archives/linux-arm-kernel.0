From: bjorn@kryo.se (Bjorn Andersson)
Date: Wed, 19 Nov 2014 11:10:54 -0800
Subject: [PATCH 1/3] genirq: Allow the irqchip state of an IRQ to be
 save/restored
In-Reply-To: <544E30B6.7060902@arm.com>
References: <1414232097-4328-1-git-send-email-marc.zyngier@arm.com>
 <1414232097-4328-2-git-send-email-marc.zyngier@arm.com>
 <alpine.DEB.2.11.1410252131110.5308@nanos>
 <alpine.DEB.2.11.1410252136220.5308@nanos>
 <544E30B6.7060902@arm.com>
Message-ID: <CAJAp7OjupqU4YT_XeQJudoapSyjf2Pp=kRWZ=O+Yacm7ZYs6MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 4:47 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
[...]
>
> Agreed, this makes a lot of sense. Will respin it.
>

Any update on this? I have a couple of drivers on the way that needs
this (querying level of an interrupt line).

Regards,
Bjorn
