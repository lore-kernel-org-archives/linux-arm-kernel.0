From: pratyush.anand@gmail.com (Pratyush Anand)
Date: Wed, 20 May 2015 21:12:28 +0530
Subject: [PATCH v2 2/2] PCI: designware: use iATU0 for cfg and IO, iATU1
 for MEM
In-Reply-To: <1430382149-1645-3-git-send-email-jszhang@marvell.com>
References: <1430382149-1645-1-git-send-email-jszhang@marvell.com>
 <1430382149-1645-3-git-send-email-jszhang@marvell.com>
Message-ID: <CAHM4w1=6mgp+gU9wUBNZg-Mpz0vOgCw1no568qLoB1X95u2YGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 1:52 PM, Jisheng Zhang <jszhang@marvell.com> wrote:
> Most transactions' type are cfg0 and MEM, so the Current iATU usage is not
> balanced, iATU0 is hot while iATU1 is rarely used. This patch refactors
> the iATU usage: iATU0 for cfg and IO, iATU1 for MEM. This allocation
> ideas comes from Minghuan Lian <Minghuan.Lian@freescale.com>:
>
>  http://www.spinics.net/lists/linux-pci/msg40440.html
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Nice optimization of resources. Thanks :)

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
