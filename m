From: olof@lixom.net (Olof Johansson)
Date: Sun, 22 Dec 2013 12:01:19 -0800
Subject: [PATCH v7 0/2] ARM: mach-moxart: add MOXA ART SoC support
In-Reply-To: <1387450064-6598-1-git-send-email-jonas.jensen@gmail.com>
References: <1387450064-6598-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20131222200119.GH9144@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 11:47:42AM +0100, Jonas Jensen wrote:
> The reason behind why fixed rate clock "ref12" couldn't be moved from
> .dtsi to .dts:
> 
> There was nothing else in "clocks { .. }", the entire block was then
> deleted from .dtsi.
> 
> If a skeleton "clocks { .. }" remain in .dtsi, the node can then be
> moved to .dts, and of_clk_get() works again.
> 
> Changes since v6:
> 
> 1. move fixed rate clock "ref12" from .dtsi to .dts
> 2. sort new entry alphabetically in arch/arm/Kconfig
> 3. rebase to next-20131219: arch/arm/Makefile arch/arm/Kconfig
> 
> Applies to next-20131219
> 
> Jonas Jensen (2):
>   ARM: mach-moxart: add MOXA ART SoC platform files
>   ARM: mach-moxart: add MOXA ART SoC device tree files

Please just send an incremental patch to fixup, I'm not going to rebuild
branches yet again because of a third version within a few hours when I've
already applied and dropped twice. :)

-Olof
