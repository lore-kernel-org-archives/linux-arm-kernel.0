From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Mar 2013 14:59:56 +0100
Subject: [PATCH v2 05/14] ARM: integrator: use clocksource_of_init for
 sp804
In-Reply-To: <20130315121554.GH4977@n2100.arm.linux.org.uk>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
 <513F7EBD.80207@gmail.com> <201303121933.47994.arnd@arndb.de>
 <513F9597.8050000@gmail.com>
 <CAD6h2NTNFZM4cgDmCJG+NrNbd27MdXGGsRCTpC1bJGeMAgcP-g@mail.gmail.com>
 <CACRpkdbCJd-ag1gLrJqJZ1D6+E5eX2tNuuNAtiKgtuBsxmrpmA@mail.gmail.com>
 <CAD6h2NRDJuGTTZ1B0iy__2SYYw7R18NRqQcwjsSvMJ3gA4E_WQ@mail.gmail.com>
 <CACRpkdZjddrHgTu+fjYVOb0Pk+1VYUU=S7LU_O_vdNKYH_vjiw@mail.gmail.com>
 <20130315121554.GH4977@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZWgScFo1G1-5XrbEKkPKq2_bG-YLB5ajR1psRiS3bauw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 1:15 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Integrator/AP selects the prescaler based on the fact that it is only a
> 16-bit counter, which has to be clocked at a rate which gives us our
> desired periodic tick interval.

Ah! I knew there was some simple explanation behind this.

Thanks Russell!
Linus Walleij
