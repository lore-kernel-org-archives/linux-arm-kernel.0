From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 20 Jan 2014 16:47:34 -0200
Subject: [PATCH 1/3] mmc: add support for power-on sequencing through DT
In-Reply-To: <20140120171621.GG15937@n2100.arm.linux.org.uk>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-2-git-send-email-olof@lixom.net>
 <20140120164859.GF15937@n2100.arm.linux.org.uk>
 <CAOMZO5AfSe_c7gfee0BcZso8ZYg=PaTDwfsXwzpEcM1554VQ6Q@mail.gmail.com>
 <20140120171621.GG15937@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5DP1axSmKcdp0e5yNakirG-_yQ1dHdoqzww3wp3CUt29w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 3:16 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Not as far as I can see.  fixed-clock appears to have two properies:
>
>         clock-frequency
>         clock-output-names
>
> and nothing else.  See of_fixed_clk_setup in drivers/clk/clk-fixed-rate.c.
> You'll also find that the documentation in this file says this about it:

Looks like Documentation/devicetree/bindings/clock/fixed-clock.txt is
misleading then:

"Optional properties:
- gpios : From common gpio binding; gpio connection to clock enable pin."

Regards,

Fabio Estevam
