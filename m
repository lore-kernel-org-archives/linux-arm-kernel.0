From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu, 14 Jun 2018 15:00:28 +0200
Subject: [PATCH 1/4] arm: dts: add support for Laird WB45N cpu module and
 DVK
In-Reply-To: <03f0f635-3fc2-085b-20e0-e1fcaa9e8062@microchip.com>
References: <1528966340-23216-1-git-send-email-ben.whitten@lairdtech.com>
 <03f0f635-3fc2-085b-20e0-e1fcaa9e8062@microchip.com>
Message-ID: <20180614130028.GA16660@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/06/2018 14:52:25+0200, Nicolas Ferre wrote:
> > +	gpio_keys {
> > +		compatible = "gpio-keys";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		irqbtn at pb18 {
> 
> I'm not sure that the @pb18 can be used like this. This address extension
> must be used in a "reg" property in the node. dtc used with warning switch
> on might trigger an error for this.
> 

Indeed, no unit-address without a reg property.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
