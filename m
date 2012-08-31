From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 31 Aug 2012 08:16:06 +0800
Subject: [PATCH 8/9] ARM i.MX53: Add pwms to dtsi
In-Reply-To: <20120831130723.GS26594@pengutronix.de>
References: <1346154504-5623-1-git-send-email-s.hauer@pengutronix.de>
 <1346154504-5623-9-git-send-email-s.hauer@pengutronix.de>
 <20120830223219.GF3613@r65073-Latitude-D630>
 <20120831130723.GS26594@pengutronix.de>
Message-ID: <20120831001604.GG3613@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 03:07:23PM +0200, Sascha Hauer wrote:
> > >  	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "63fcc000.ssi");
> > >  	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "50014000.ssi");
> > >  	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "63fd0000.ssi");
> > > +	clk_register_clkdev(clk[pwm1_ipg_gate], "ipg", "53fb4000.pwm");
> > > +	clk_register_clkdev(clk[pwm1_hf_gate], "per", "53fb4000.pwm");
> > > +	clk_register_clkdev(clk[pwm2_ipg_gate], "ipg", "53fb8000.pwm");
> > > +	clk_register_clkdev(clk[pwm2_hf_gate], "per", "53fb8000.pwm");
> > 
> > It should be in a separate patch?
> 
> Should it? Surely I can do this, I had the feeling though that it
> belongs together.
> 
>From patch subject, I do not expect these changes in the patch.  It's
okay to have it but we need a more proper patch subject then.  

-- 
Regards,
Shawn
