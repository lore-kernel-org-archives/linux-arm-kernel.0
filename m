From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Fri, 30 Mar 2012 15:02:35 +0200
Subject: [PATCH] ARM: at91: add support for Telit GE863-PRO3 Evaluation Kit
In-Reply-To: <20120330115906.GM7757@game.jcrosoft.org>
References: <1333097816-8641-1-git-send-email-fabio.porcedda@gmail.com>
 <20120330115906.GM7757@game.jcrosoft.org>
Message-ID: <CAHkwnC9XZneX-9def=0VYifyVDG4ZtXo1L+ZJNQDhxSm1fPj9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 1:59 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> tks for the patch but now we have close the non dt board for this soc

Thanks for the reply.

> and for 3.5 nearly all the devices of this soc will converted to DT
>
> so you need to switch to DT too

Ok, i will switch to DT too.
Do you plan to add support to any 9260 board to the board-dt.c for 3.5?
I think that, as far as there is a working 9260 board using DT, i can
work on the GE863-PRO3 support using DT.

> As today I've not finished the pinctrl support you need to do all the pin mux
> in the bootlader. For 3.5 it will not be the case anymore
>
> Best Regards,
> J.

Thanks and regards
-- 
Fabio Porcedda
