From: pratyush.anand@gmail.com (Pratyush Anand)
Date: Wed, 20 May 2015 20:48:34 +0530
Subject: [PATCH v2 1/2] PCI: designware: consolidate outbound iATU
 programming functions
In-Reply-To: <1430382149-1645-2-git-send-email-jszhang@marvell.com>
References: <1430382149-1645-1-git-send-email-jszhang@marvell.com>
 <1430382149-1645-2-git-send-email-jszhang@marvell.com>
Message-ID: <CAHM4w1n5+xk7Xymo4erxzw-ojC0z76uZe9C5k=9Rrt-TgbaO_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 1:52 PM, Jisheng Zhang <jszhang@marvell.com> wrote:
> Currently, the outbound iATU programming functions are similar, the only
> difference is index, type, addr and size. This patch tries to consolidate
> these functions into one. One side effect is it saves around 1700 bytes in
> text:
>
>    text    data     bss     dec     hex filename
>    9276     204       4    9484    250c pcie-designware.o-before
>    7532     204       4    7740    1e3c pcie-designware.o
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

looks fine to me.

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
