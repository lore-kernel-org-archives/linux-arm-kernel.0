From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 19 Dec 2017 21:46:14 +0100
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <CAPv3WKddg82waiapD8JzH0pCsWVTE2iT0LFz7PCYrrDDpXqmbw@mail.gmail.com>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
 <20171219.134810.48027351795338458.davem@davemloft.net>
 <CAPv3WKddg82waiapD8JzH0pCsWVTE2iT0LFz7PCYrrDDpXqmbw@mail.gmail.com>
Message-ID: <20171219204614.GA24156@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Of course! v2 will not have such problem, I've been waiting however
> for the feedback about the ACPI representation. Anyway, I'm strongly
> leaning towards using _ADR/_CID objects in PHY's nodes for ACPI, so
> maybe I'll just issue the v2 in order to push the discussion a bit
> forward.
 
Hi Marcin

I know ~0 about ACPI. But what seems to be missing for me is
documentation. You are defining a ABI here, which all future MDIO
busses, PHYs, and to some extent Ethernet switches need to follow. So
i would expect this to be documented somewhere.

How does documentation work in the ACPI world?

    Andrew
