From: Ben.Whitten@lairdtech.com (Ben Whitten)
Date: Fri, 13 Jul 2018 08:37:35 +0000
Subject: [PATCH v2 4/6] arm: dts: add support for Laird WB50N cpu module
 and DVK
In-Reply-To: <20180712215435.GL16084@piout.net>
References: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
 <1529070055-18701-4-git-send-email-ben.whitten@lairdtech.com>
 <20180712215435.GL16084@piout.net>
Message-ID: <CY1PR02MB11204031D35B61A5CD6B5940E7580@CY1PR02MB1120.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH v2 4/6] arm: dts: add support for Laird
> WB50N cpu module and DVK
> 
> Hi,
> 
> I've now applied the whole series after fixing two small
> whitespace
> issues.

Thanks!

> On 15/06/2018 14:40:53+0100, Ben Whitten wrote:
> > +&usart1_clk {
> > +	atmel,clk-output-range = <0 132000000>;
> > +};
> > +
> 
> But this is not actually allowed by the hardware (well, it is
> but it
> will lead to issues) and will be removed once the clock
> binding is
> reworked.

Of course no problem, thanks again.

Ben
