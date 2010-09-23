From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 23 Sep 2010 14:00:23 +0200
Subject: [PATCH] at91sam9g45: fix i2c bus speed
In-Reply-To: <87zkv88zln.fsf@macbook.be.48ers.dk>
References: <1285147886-17100-1-git-send-email-jacmet@sunsite.dk>
	<4C9B0D4D.4050102@atmel.com> <87k4mcak6b.fsf@macbook.be.48ers.dk>
	<20100923093104.GA22397@n2100.arm.linux.org.uk>
	<87fwx0ahgl.fsf@macbook.be.48ers.dk>
	<20100923103645.GA23295@n2100.arm.linux.org.uk>
	<877hicafx5.fsf@macbook.be.48ers.dk>
	<20100923111604.GZ32018@game.jcrosoft.org>
	<87zkv88zln.fsf@macbook.be.48ers.dk>
Message-ID: <20100923120023.GD32018@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:32 Thu 23 Sep     , Peter Korsgaard wrote:
> >>>>> "Jean-Christophe" == Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> writes:
> 
> Hi,
> 
>  >> And yes, if you run the SoC at nonstandard (slower) speed this might be
>  >> slower than 100Khz, but that's still safe, so not a big deal.
> 
>  Jean-Christophe> except you can also overclock the SoC in some case so
>  Jean-Christophe> it's still not safe
> 
> Sure, you can do lots of crazy stuff. Instead of discussion this back
> and forward, do you agree that udelay=5 is better/safer/more sensible
> than the current udelay=2 value?
no it's not safer it's hardcoded value where it's board specific
so we just close our eyes on the problem by doing this
it's time to fix it correctly
> 
>  Jean-Christophe> and force this speed for all boards :(
> 
> Just like it has always been.
does not means it's right

Best Regards,
J.
