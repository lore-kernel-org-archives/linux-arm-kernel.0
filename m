From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 9 Jan 2018 14:00:12 +0100
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <CAPv3WKehwsrxuxemgL_5fKtUT2xjqkE6yf9DMcCcO2WRJ6nQaQ@mail.gmail.com>
References: <CAPv3WKcM8WWvh64A=FTtuWkEr6V_QSKjBpNpWnMpp_P=cMU9sw@mail.gmail.com>
 <20180104160939.GA7785@xora-haswell>
 <20180104162036.GL3401@lunn.ch>
 <20180108144548.GA31502@xora-haswell>
 <20180108145312.GH10940@lunn.ch>
 <20180108151453.GB31502@xora-haswell>
 <20180108154243.GA30962@lunn.ch>
 <CAPv3WKewA+7WabMYN1w=9fOxe6zOKDbxcjX0VipumQmfZtJKjQ@mail.gmail.com>
 <20180109101941.GD31502@xora-haswell>
 <CAPv3WKehwsrxuxemgL_5fKtUT2xjqkE6yf9DMcCcO2WRJ6nQaQ@mail.gmail.com>
Message-ID: <20180109130012.GA27447@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 11:22:00AM +0100, Marcin Wojtas wrote:
> 2018-01-09 11:19 GMT+01:00 Graeme Gregory <graeme.gregory@linaro.org>:
> > On Mon, Jan 08, 2018 at 06:17:06PM +0100, Marcin Wojtas wrote:
> >> Hi Andrew,
> >>
> >>
> >>
> >> 2018-01-08 16:42 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
> >> > w> I am not familiar with MDIO, but if its similar or a specific
> >> >> implementation of a serial bus that does sound sane!
> >> >
> >>
> >> Thanks for digging, I will check if and how we can use
> >> GenericSerialBus with MDIO.
> >>
> > Maybe Lorenzo, Hanjun, Sudeep can comment here they might have come
> > across similar on other ARM boards.
> >
> 
> I'm looking forward to their feedback, however, what I've noticed,
> each driver handles mdio/phys on its own, not using any generic
> solution, which is what I need to actually avoid :)

Agreed. Lets define it once for all drivers using phylib/phylink.

	Andrew
