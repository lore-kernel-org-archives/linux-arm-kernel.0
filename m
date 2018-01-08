From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 8 Jan 2018 18:17:06 +0100
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <20180108154243.GA30962@lunn.ch>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
 <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
 <20180103110048.GA21230@xora-haswell>
 <CAPv3WKcM8WWvh64A=FTtuWkEr6V_QSKjBpNpWnMpp_P=cMU9sw@mail.gmail.com>
 <20180104160939.GA7785@xora-haswell> <20180104162036.GL3401@lunn.ch>
 <20180108144548.GA31502@xora-haswell> <20180108145312.GH10940@lunn.ch>
 <20180108151453.GB31502@xora-haswell> <20180108154243.GA30962@lunn.ch>
Message-ID: <CAPv3WKewA+7WabMYN1w=9fOxe6zOKDbxcjX0VipumQmfZtJKjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,



2018-01-08 16:42 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
> w> I am not familiar with MDIO, but if its similar or a specific
>> implementation of a serial bus that does sound sane!
>

Thanks for digging, I will check if and how we can use
GenericSerialBus with MDIO.

Best regards,
Marcin

> It is a two wire serial bus. A good overview can be found here:
>
> https://www.totalphase.com/support/articles/200349206-MDIO-Background
>
