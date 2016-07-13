From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 13 Jul 2016 15:08:00 +0200
Subject: at91-sama5d4ek.dts, lcd_bus node?
In-Reply-To: <alpine.DEB.2.02.1607131228320.10743@pmeerw.net>
References: <alpine.DEB.2.02.1607131228320.10743@pmeerw.net>
Message-ID: <20160713130800.GA898@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/07/2016 at 12:33:36 +0200, Peter Meerwald-Stadler wrote :
> Hello,
> 
> is the lcd_bus stuff still needed in at91-sama5d4ek.dts?
> 

It is not, I just prepared a patch yesterday regarding this issue that I
didn't send yet (part of the dtc warnings cleanup).

> the sama5d4_xplained*.dts don't seem to have it and I don't see any 
> reference to it
> 
> thanks, regards, p.
> 
> -- 
> 
> Peter Meerwald-Stadler
> +43-664-2444418 (mobile)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
