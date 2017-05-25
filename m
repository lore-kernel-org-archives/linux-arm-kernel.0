From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 25 May 2017 16:20:32 +0800
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-b: add hi8435 device
In-Reply-To: <eb86f383-3c27-2276-6213-99c5143420f5@cogentembedded.com>
References: <20170522131010.3537-1-nikita.yoush@cogentembedded.com>
 <20170525070007.GU26102@dragon>
 <eb86f383-3c27-2276-6213-99c5143420f5@cogentembedded.com>
Message-ID: <20170525082030.GB26102@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 11:06:47AM +0300, Nikita Yushchenko wrote:
> >> +&edma1 {
> >> +	status = "okay";
> >> +};
> >> +
> >> +&dspi2 {
> > 
> > Please keep these labelled nodes sort alphabetically.
> 
> Ok
> 
> >> +	bus-num = <1>;
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&pinctrl_dspi2>;
> >> +	status = "okay";
> > 
> > We usually have 'status' line at the bottom of property list.
> 
> Ok
> 
> >> +	spi-num-chipselects = <2>;
> >> +
> >> +	hi8435 at 1 {
> > 
> > Node name should be something generic, while label can be specific
> > model name.  The following form might be better.
> > 
> > 	hi8435: sensor at 1
> 
> Ok
> 
> Although the same file, in lines nearby, has m25p128 at 0 and at93c46d at 1.

It seems that I need more eyes to help review.

Shawn
