From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 1 Jun 2015 15:01:25 +0200
Subject: [RESEND PATCH 0/2] pinctrl: zynq: fix two bugs of zynq pinmux
 function
In-Reply-To: <20150520142358.GS31550@xsjsorenbubuntu>
References: <1432111351-21336-1-git-send-email-yamada.masahiro@socionext.com>
 <20150520142358.GS31550@xsjsorenbubuntu>
Message-ID: <CACRpkdbpW6i2SNz254gt+T8TPw=gBzB68dQ2TmVNbwc41dT=1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 4:23 PM, S?ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> For the series:
> Reviewed-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

Ah that is S?ren's Review tag.

> It may be a good ides to add
>   Fixes: add958cee967 "pinctrl: Add driver for Zynq"
> (I suspect that bug is there from the beginning) and ask Linus to
> consider this for stable.

I added it but still merging for -next at this point. No need to
rush this fix since it's been around so long.

Yours,
Linus Walleij
