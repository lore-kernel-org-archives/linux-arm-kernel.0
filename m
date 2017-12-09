From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Sat, 9 Dec 2017 20:27:57 -0300
Subject: [PATCH 00/12] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
Message-ID: <CAAEAJfC6Ctxfuk+jv=Z7__4ME6VtDdQk-H74hiN19gcEo6HOxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Miquel,

On 7 December 2017 at 17:18, Miquel Raynal
<miquel.raynal@free-electrons.com> wrote:
> Hi,
>
> After the addition of the NAND framework ->exec_op() interface (see [1]
> for the series preparing it and [2] for the last version of the
> core-side implementation of ->exec_op() itself), this series replaces
> the current Marvell NAND controller driver pxa3xx_nand.c with a rework
> called marvell_nand.c.
>

Nice to see this effort!

Unfortunately, I don't much time to spend reviewing this, but I'm super
happy to see a new driver fixing all the nasty issues the current one has.

Cheers,
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
