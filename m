From: joel@jms.id.au (Joel Stanley)
Date: Mon, 26 Mar 2018 10:28:30 +1030
Subject: [PATCH v2 0/7] KASan for arm
In-Reply-To: <20180318125342.4278-1-liuwenliang@huawei.com>
References: <20180318125342.4278-1-liuwenliang@huawei.com>
Message-ID: <CACPK8XemuC+uACYp=tP1gJ8=9k-S69saebOLmq8nrZtqPxWRjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 March 2018 at 23:23, Abbott Liu <liuwenliang@huawei.com> wrote:

>    These patches add arch specific code for kernel address sanitizer
> (see Documentation/kasan.txt).

Thanks for implementing this. I gave the series a spin on an ASPEED
ast2500 (ARMv5) system with aspeed_g5_defconfig.

It found a bug in the NCSI code (https://github.com/openbmc/linux/issues/146).

Tested-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
