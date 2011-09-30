From: jaccon.bastiaansen@gmail.com (Jaccon Bastiaansen)
Date: Fri, 30 Sep 2011 11:01:10 +0200
Subject: [PATCH] Add platform driver support to the CS890x driver
In-Reply-To: <20110928083048.GA15311@glitch.intra.local>
References: <1315390967-6683-1-git-send-email-jaccon.bastiaansen@gmail.com>
	<20110907125047.GU28816@pengutronix.de>
	<CAGzjT4f3VDL-rDzup4kSc11eCdhR9s7fxf8RYNjEZmK9Rk50Cw@mail.gmail.com>
	<20110910141244.GQ28816@pengutronix.de>
	<CAGzjT4f2agA30TGb8XFSRu57=--qyBt=bU5QWVTmU6LAGmwM8A@mail.gmail.com>
	<20110911185312.GD28624@pengutronix.de>
	<CAGzjT4ce0gZ2e6cM1PfUb9JkZ=52PUCjPz1C9qjjRYxgSJckbQ@mail.gmail.com>
	<20110928083048.GA15311@glitch.intra.local>
Message-ID: <CAGzjT4fkjs7j=a0P=EcPcx-KJpZsMy=cmpYd2STO3Mk8yhoT_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Domenico,

2011/9/28 Domenico Andreoli <cavokz@gmail.com>:
> Hi Jaccon,
>
> On Mon, Sep 12, 2011 at 12:52:52PM +0200, Jaccon Bastiaansen wrote:
>>
>> Ok, so you would like to see the #ifdefs for the IXDP2351, IXDP2X01,
>> QQ2440 and MX31ADS in the cs890x driver replaced by platform_device
>> definitions in the platform specific code of those platforms (in the
>> same way as I have done for the i.MX21ADS platform)? Is this correct?
>
> Feel free to completely dump the QQ2440 thing, the QQ2440 board support
> is not in mainline and will not until it can be implemented mostly with
> DT, I guess. ?At that time I will be happy to use your platform device
> conversion - with the OF initialization that sombody will write ;)
>
> I will test it.
>
> cheers,
> Domenico
>


This patch does what you describe and removes the QQ2440 board support.

Regards,
  Jaccon
