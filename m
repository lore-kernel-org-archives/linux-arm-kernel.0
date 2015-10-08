From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 08 Oct 2015 11:41:49 +0300
Subject: [PATCH v3 00/16] KVM: arm64: GICv3 ITS emulation
In-Reply-To: <20151007204810.66e2b1d6@arm.com>
References: <1444229726-31559-1-git-send-email-andre.przywara@arm.com>
 <029601d1011a$026e1000$074a3000$@samsung.com> <561546AF.90903@arm.com>
 <02c301d1012b$42cb8270$c8628750$@samsung.com>
 <20151007204810.66e2b1d6@arm.com>
Message-ID: <005301d101a5$35700360$a0500a20$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

 Sorry for taking up your time, and thank you very much for the explanation.

> I'd appreciate if you could try to read and understand the architecture
> spec instead of randomly googling and quoting various bits of
> irrelevant information.

 I give my apologizes for not having time to read the whole specs from beginning to the end. Can
only add that it's quite weird to have these important things in "Terminology" section. I would
expect them to be in 6.1, for example. That was the part i read, but failed to find the exact
answer:
--- cut ---
LPIs do not have an active state, and transition to the inactive state on being acknowledged by a PE
--- cut ---

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
