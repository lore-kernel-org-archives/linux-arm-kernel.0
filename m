From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 Apr 2014 07:57:53 +0100
Subject: [PATCH 2/4] mfd: bcm590xx: add support for second i2c slave
 address space
In-Reply-To: <20140416213141.GD12304@sirena.org.uk>
References: <1397501428-8857-1-git-send-email-mporter@linaro.org>
 <1397501428-8857-3-git-send-email-mporter@linaro.org>
 <20140416110603.GA19671@lee--X1>
 <20140416213141.GD12304@sirena.org.uk>
Message-ID: <20140417065753.GC28725@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > s/regmap/Regmap
> 
> It's consistently written regmap in all the documentation and so on :)

Furry muff; but the comments still stand for the acronyms.

> > addmap{0,1} doesn't quite sit right with me.
> 
> > REVISIT: Ah, it's address-map, rather than add map. Okay, not as bad
> > as I first thought, but still, is there a better naming convention you
> > could use?
> 
> addrmap or something?

Right, that was what I was thinking. However, I prefer something along
the lines of 'i2c' and 'i2c_sec' or 'client' and 'client_slv' etc.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
