From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Mon, 4 Dec 2017 13:41:08 +0100
Subject: [patch v13 2/4] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <1512382405-14774-3-git-send-email-oleksandrs@mellanox.com>
References: <1512382405-14774-1-git-send-email-oleksandrs@mellanox.com>
 <1512382405-14774-3-git-send-email-oleksandrs@mellanox.com>
Message-ID: <CAOFm3uGYCssRV4D+Ht6NQLxFSijWt0dgsQEucJmVThjLqiD-oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oleksandr,

On Mon, Dec 4, 2017 at 11:13 AM, Oleksandr Shamray
<oleksandrs@mellanox.com> wrote:
[...]
> v12->v13
> Comments pointed by Philippe Ombredanne <pombredanne@nexb.com>
> - Change jtag-aspeed.c licence type to
>   SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>   and reorder line with license in description
[...]
> diff --git a/drivers/jtag/jtag-aspeed.c b/drivers/jtag/jtag-aspeed.c
> new file mode 100644
> index 0000000..2ff46b0
> --- /dev/null
> +++ b/drivers/jtag/jtag-aspeed.c
> @@ -0,0 +1,784 @@
> +/* SPDX-License-Identifier: GPL-2.0

Sorry to nit pick on this but the comment style should be // here IMHO
This is what Linus requested, e.g.:

> +// SPDX-License-Identifier: GPL-2.0

For reference, the doc is being written:Thomas (tglx) has already
submitted a first series of doc patches a few weeks ago. And AFAIK he
might be working on posting the updates soon, whenever his real time
clock yields a few cycles away from real time coding work ;)

See also these discussions with Linus [1][2][3], Thomas[4] and Greg[5]
on this and mostly related topics, where you will see Linus rationale
for the C++ comment stylle

[1] https://lkml.org/lkml/2017/11/2/715
[2] https://lkml.org/lkml/2017/11/25/125
[3] https://lkml.org/lkml/2017/11/25/133
[4] https://lkml.org/lkml/2017/11/2/805
[5] https://lkml.org/lkml/2017/10/19/165


-- 
Cordially
Philippe Ombredanne
