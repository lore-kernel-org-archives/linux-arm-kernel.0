From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Fri, 18 Jun 2010 19:40:04 +0200
Subject: [PATCH v2] input/imx_keypad: add PM support
In-Reply-To: <4C1B84A3.8080300@eukrea.com>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com>
	<1276856186.3146.5.camel@realization>  <4C1B84A3.8080300@eukrea.com>
Message-ID: <1276882804.3146.14.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ven, 2010-06-18 at 16:37 +0200, Eric B?nard wrote:
> Hi Alberto,
> 
> Le 18/06/2010 12:16, Alberto Panizzo a ?crit :
> > Ok, so with this patch the keypad cannot wake the system?
> > It is scheduled another patch?
> >
> well, actually, the keypad wakes the system, at least on my board here.
> 
> I was quite surprised to get this working this way as I would have 
> expected disable_irq + clk_disable would prevent the keypad from being a 
> wake source.
> Can you try on your board as this cleanup may be wrong on i.MX3 ?
> 
> Thanks,
> Eric
Well.. it is a surprise to me too. I have to look down the documentation
ad soon I will try on the mx31pdk.
I don't wont to tell you wrong things.


-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
