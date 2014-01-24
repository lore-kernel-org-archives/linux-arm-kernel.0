From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 24 Jan 2014 15:35:23 -0200
Subject: [PATCH 1/3] mmc: add support for power-on sequencing through DT
In-Reply-To: <20140120164859.GF15937@n2100.arm.linux.org.uk>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-2-git-send-email-olof@lixom.net>
 <20140120164859.GF15937@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5DdTP0gimwdsBUZK3wXrnUd2FN3w-FszLQkvCwM8gvPpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 2:48 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> So far so good.  Now, what about this external oscillator which has its
> own separate power control.  My immediate thought is that this can be
> specified via card_ext_clock - I would simply need to declare a fixed-rate
> clock with either a regulator (power switch) controlled via a gpio (which
> would probably be closer to the hardware) or a gpio as an enable... ah,
> that requires me to write a common clock driver for that bit since this
> is currently not modelled by CCF...

Jiry Sarha posted a gpio controlled clock proposal:
http://www.spinics.net/lists/devicetree/msg16651.html

Regards,

Fabio Estevam
