From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 10 Sep 2014 21:01:52 +0800
Subject: [PATCH V2 3/3] ARM: imx: source gpt per clk from OSC for system
 timer
In-Reply-To: <8DDD46F6-AA96-4E14-ADD6-45A1AD12423C@freescale.com>
References: <1409887606-22388-1-git-send-email-b20788@freescale.com>
 <1409887606-22388-4-git-send-email-b20788@freescale.com>
 <CAOMZO5CJLSXy3p-eAe9xOJw8p4gxoRuT91bXV8gswy5oMuU6XQ@mail.gmail.com>
 <5E619FDB-56BB-486E-B627-9D2A9D4F9F54@freescale.com>
 <20140910073333.GC22579@dragon>
 <7fd82b8c08c54f4dadb6b7402231a086@BN1PR0301MB0628.namprd03.prod.outlook.com>
 <20140910114936.GE22579@dragon>
 <8DDD46F6-AA96-4E14-ADD6-45A1AD12423C@freescale.com>
Message-ID: <20140910130150.GF22579@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 12:31:48PM +0000, Anson.Huang at freescale.com wrote:
> I think it should be OK now, but for the "try osc_per clk first ..." the check
> should be as below?
> 
> If (IS_ERR(clk_per))
>       clk_per = of_clk_get_by_name(np, "per");
> 

Ah, yes.  That was a mistake in my example code.

Shawn
