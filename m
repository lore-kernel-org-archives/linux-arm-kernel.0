From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 27 Jan 2015 00:06:45 +0100
Subject: [PATCH 1/2] clk: pxa: add pxa3xx clock driver
In-Reply-To: <1420577139-30556-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Tue, 6 Jan 2015 21:45:38 +0100")
References: <1420577139-30556-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87wq49p2ey.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Move pxa25x clock drivers from arch/arm/mach-pxa to driver/clk.
> In the move :
>  - convert to new clock framework legacy clocks
>  - provide clocks as before for platform data based boards
>  - provide clocks through devicetree with clk-pxa-dt
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Hi Mike,

Would there be a change for this to land in 3.20 (only patch 1/2) ?

Of course it won't be activated, as my intention is to use 3.21 as my vehicle to
swap pxa25x, pxa27x and pxa3xx to common clock framework though pxa tree.

FWIW, this was tested on the zylonite board so far.

Cheers.

--
Robert
