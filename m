From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 26 Sep 2014 07:51:15 +0000
Subject: [PATCHv4 2/6] ARM: dts: Add initial LS1021A QDS board dts support
In-Reply-To: <20140926061354.GD31948@dragon>
References: <1411371952-5618-1-git-send-email-jingchang.lu@freescale.com>
 <1411371952-5618-3-git-send-email-jingchang.lu@freescale.com>
 <20140926061354.GD31948@dragon>
Message-ID: <8afdf8783f3c47558f35b7e88e2cde3c@BY2PR0301MB0613.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[...]
> > +
> > +	soc {
> > +		leds {
> 
> I think leds are board level devices and do not have to be under node
> "soc"?
> 
@Shawn,
Yes, it is.

@Jingchang,
For now we could just remove the led nodes here. There hasn't any real leds
On QDS(and for now we have to test their output pulse).

So this could be added later when need.

> > +			compatible = "pwm-leds";
> 
> Please have a new line between property list and device node ...
> 
This and the following issues about led will be fixed when adding this node separately
In the future.

[...]

Thanks,

BRs
Xiubo
