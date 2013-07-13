From: dsd@laptop.org (Daniel Drake)
Date: Sat, 13 Jul 2013 08:30:59 -0600
Subject: [PATCH V3 1/3] dts: change Marvell prefix to 'marvell'
In-Reply-To: <CAN1soZzQz8PaHOwNf-Ec6G=ahhx_P8gaaX4fQnpX-Mqrepk_7g@mail.gmail.com>
References: <1373352166-10064-1-git-send-email-zhangwm@marvell.com>
 <1373352166-10064-2-git-send-email-zhangwm@marvell.com>
 <20130709124900.GG11908@titan.lakedaemon.net>
 <CAN1soZxiOh6TpbUOCUzK8gNwmvjbT3ihkUWaw8tuZ7md+NVA2g@mail.gmail.com>
 <20130710122433.GO11908@titan.lakedaemon.net>
 <CAN1soZzMvront1-jcBW6-uRKNs0OZNGnmiOjKGZSM28bViB_8A@mail.gmail.com>
 <20130710215041.GR11908@titan.lakedaemon.net>
 <CAN1soZzuiukY9qASFNcH0k=zH8=uT=71bKejPss44FCzNy=X-A@mail.gmail.com>
 <CAMLZHHQGZvDssY-YxQ3ZW8FYhpG-H1-VbokOid33socRSPrMNw@mail.gmail.com>
 <CAN1soZzQz8PaHOwNf-Ec6G=ahhx_P8gaaX4fQnpX-Mqrepk_7g@mail.gmail.com>
Message-ID: <CAMLZHHSDu+zgumVtWeU8yGiJ8Wmp3TQJbEc6u54LziOC5oXPeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 6:35 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> These patches couldn't be applied. Since we're moving irq drivers from arch
> directories to irq directories.

It does not seem in line with the collaborative manner of kernel
development to block my patches for a whole month because they
conflict with your own private patches which do not exist for anyone
else (at least I searched and couldn't find them).

Please, either post your patches immediately (I will help review), or
review mine and figure out how to handle any conflict with your own
work afterwards.

> When the irq patches are applied, you can rebase your patches.

2 of the pending patches don't touch the irq stuff anyway.

Daniel
