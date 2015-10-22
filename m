From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 22 Oct 2015 18:55:24 +0300
Subject: [PATCH v3 08/16] KVM: arm64: handle ITS related GICv3
 redistributor registers
In-Reply-To: <015d01d10ce0$cb7009a0$62501ce0$@samsung.com>
References: <1444229726-31559-1-git-send-email-andre.przywara@arm.com>
 <1444229726-31559-9-git-send-email-andre.przywara@arm.com>
 <015d01d10ce0$cb7009a0$62501ce0$@samsung.com>
Message-ID: <015e01d10ce2$112c6780$33853680$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

 One more idea...

>  Here you store lpis_enabled globally, and this is plain wrong.

 By the way, may be we should move this flag, together with pendbaser array, into struct vgic_cpu? Then we would not have to
allocate them manually.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
