From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 1 Jan 2018 11:04:30 +0100
Subject: [net-next: PATCH v2 4/5] net: mvpp2: use device_*/fwnode_* APIs
 instead of of_*
In-Reply-To: <20171231191836.GA20455@lunn.ch>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-5-git-send-email-mw@semihalf.com>
 <20171231191836.GA20455@lunn.ch>
Message-ID: <CAPv3WKfiR_ekc-ODPfYWDkP0UG0znRxsTCr6FPePgZVXB5J_zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

2017-12-31 20:18 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
> On Sun, Dec 31, 2017 at 12:58:39PM +0100, Marcin Wojtas wrote:
> Hi Marcin
>
>> Because there is no equivalent for for_each_available_child_of_node(),
>> use device_for_each_child_node() and check the port availability
>> inside the mvpp2_port_probe() routine.
>
> Could device_each_available_child_node() be added? I guess this will
> not be the last driver converted in this way, and having that macro
> will help with future ports.
>

Sure, I can add it in the next round.

Thanks,
Marcin
