From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 13 Aug 2017 17:49:20 +0200
Subject: SUN8I_EMAC driver wanted (for Orange Pi)
In-Reply-To: <3792055e-d56f-e722-d9f8-519b46fd73dd@ozlabs.ru>
References: <3792055e-d56f-e722-d9f8-519b46fd73dd@ozlabs.ru>
Message-ID: <20170813154920.GA31401@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 01:09:15AM +1000, Alexey Kardashevskiy wrote:
> Hi!
> 
> I have been using v4.8 with some driver I found somewhere. Ported to v4.13,
> it does not work anymore and I wonder if anyone has an idea where to get a
> working one from?

Hi Alexey

A driver for this was added to Linux May 31st. Try 4.13-rcX enabling
DWMAC_SUN8I.

  Andrew
