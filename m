From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 24 Aug 2017 15:12:21 +0200
Subject: [PATCH v2 3/4] net: phy: realtek: add disable RX internal delay
 mode
In-Reply-To: <7c43220aef447e5cf21e48a9eca18535@aosc.io>
References: <20170822040400.12166-1-icenowy@aosc.io>
 <20170822040400.12166-4-icenowy@aosc.io>
 <20170822133906.GG24555@lunn.ch>
 <7c43220aef447e5cf21e48a9eca18535@aosc.io>
Message-ID: <20170824131221.GA8022@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >Do we know that the TX lines do have a delay after making this change?
> >We need to be careful here. We will get into a mess if this is
> >actually RGMII not RGMII_TXID, and somebody designs a board which
> >needs RGMII-TXID.
> 
> In fact I'm not sure -- I'm even not sure that after making this change
> there's no TX delay. The change is totally not documented, so I choose
> to use a custom property in v1.

Can you get in touch with Realtek and ask? Or can you get a hardware
guy to do some measurements?

Thanks
    Andrew
