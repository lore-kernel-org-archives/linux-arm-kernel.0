From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Oct 2012 23:15:21 +0200
Subject: [PATCH 4/6] ARM: ux500: Add UART support to the u9540 Device Tree
In-Reply-To: <20121011180612.GY12801@game.jcrosoft.org>
References: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
 <1349882335-6786-5-git-send-email-lee.jones@linaro.org>
 <20121010190325.GT12801@game.jcrosoft.org>
 <20121011072927.GR9707@gmail.com>
 <20121011085002.GV12801@game.jcrosoft.org>
 <20121011092222.GW9707@gmail.com>
 <20121011180612.GY12801@game.jcrosoft.org>
Message-ID: <CACRpkdb9xCzpsidy9Ro+yauzwV7r+xPYOb8NAG8mfn=h8fuKVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2012 at 8:06 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 10:22 Thu 11 Oct     , Lee Jones wrote:

>> The board could actually be called either ccu9540, or just
>> u9540. I picked one and went with it. The full name is the
>> u9540 development board.
>
> so use ccu9540 as u9540 is the soc name so if we use u9540 as compatible we
> expect to mach the soc and not a board

I basically agree.

However the SoC (digital ASIC) is named DB9540.

U9540 is the entire chipset (DB9540, AB9540 etc) a variant
of the NovaThor series.

Yours,
Linus Walleij
