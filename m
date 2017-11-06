From: jhogan@kernel.org (James Hogan)
Date: Mon, 6 Nov 2017 10:41:47 +0000
Subject: [PATCH 1/2] MIPS: dts: remove bogus bcm96358nb4ser.dtb from
 dtb-y entry
In-Reply-To: <CAK7LNAQfK_BWQcVW-ScrpAwNAHav3MrrzV-tjn_YUjsuvd7U5A@mail.gmail.com>
References: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
 <1509859853-27473-2-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQfK_BWQcVW-ScrpAwNAHav3MrrzV-tjn_YUjsuvd7U5A@mail.gmail.com>
Message-ID: <20171106095139.GG15260@jhogan-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Nov 05, 2017 at 11:11:38PM +0900, Masahiro Yamada wrote:
> +CC Ralf Baechle <ralf@linux-mips.org>
> +CC linux-mips at linux-mips.org
> +CC Kevin Cernekee <cernekee@gmail.com>
> +CC Florian Fainelli <f.fainelli@gmail.com>
> 
> 
> I missed to CC MIPS maintainers.

Yes, please resend the patch so it lands in patchwork.linux-mips.org.

> 2017-11-05 14:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> > arch/mips/boot/dts/brcm/bcm96358nb4ser.dts does not exist, so
> > we cannot build bcm96358nb4ser.dtb .

This appears to be due to the file being renamed in commit 695835511f96
("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom").
Please can you update the commit message when you resend to mention the
cause of the problem.

You could also add the following if you like while you're at it:

Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom")
Cc: <stable@vger.kernel.org> # 4.9+

Thanks
James
