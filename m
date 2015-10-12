From: p.fedin@samsung.com (Pavel Fedin)
Date: Mon, 12 Oct 2015 18:18:39 +0300
Subject: [PATCH v3 00/16] KVM: arm64: GICv3 ITS emulation
In-Reply-To: <561BBFC1.4070200@arm.com>
References: <1444229726-31559-1-git-send-email-andre.przywara@arm.com>
 <20151010153744.GH29128@cbox> <561BBFC1.4070200@arm.com>
Message-ID: <00dc01d10501$46352810$d29f7830$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> Also what is the status of Eric's IRQ routing support? Should this go in
> first now?

 I'd say without vITS there's nothing to use IRQ routing with. It could go in and just lay around
silently, so that it's not forgotten, but for example current qemu just knows that with GICv2m it
should use hardcoded linear MSI->SPI mapping.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
