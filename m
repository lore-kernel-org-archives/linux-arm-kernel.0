From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 20 Dec 2017 00:13:01 +0100
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <20171219204614.GA24156@lunn.ch>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
 <20171219.134810.48027351795338458.davem@davemloft.net>
 <CAPv3WKddg82waiapD8JzH0pCsWVTE2iT0LFz7PCYrrDDpXqmbw@mail.gmail.com>
 <20171219204614.GA24156@lunn.ch>
Message-ID: <CAPv3WKcYSQeUnNr20T_M3B-upg0Z=CnVS9fvd=v18Tbh4T7FWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

2017-12-19 21:46 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
>> Of course! v2 will not have such problem, I've been waiting however
>> for the feedback about the ACPI representation. Anyway, I'm strongly
>> leaning towards using _ADR/_CID objects in PHY's nodes for ACPI, so
>> maybe I'll just issue the v2 in order to push the discussion a bit
>> forward.
>
> Hi Marcin
>
> I know ~0 about ACPI. But what seems to be missing for me is
> documentation. You are defining a ABI here, which all future MDIO
> busses, PHYs, and to some extent Ethernet switches need to follow. So
> i would expect this to be documented somewhere.

As the code derives straight from of_mdio.c, there is absolutely no
deviation from Documentation/devicetree/bindings/net/mdio.txt.

>
> How does documentation work in the ACPI world?
>

ACPI has its own specification, the newest one is 6.2
http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf

It is pretty likely, that if we establish a generic solution for the
MDIO bus, a short section about it may probably require adding to
above - for now I see none.

Best regards,
Marcin
