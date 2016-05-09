From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 May 2016 15:12:12 +0200
Subject: [PATCH v2 1/2] Documentation: DT: bindings: Add Broadcom STB PCIe
 bindings
In-Reply-To: <572BBF2E.5010606@broadcom.com>
References: <1462475700-1654-1-git-send-email-f.fainelli@gmail.com>
 <4513390.VWu0VVAxOl@wuerfel> <572BBF2E.5010606@broadcom.com>
Message-ID: <20692845.Ts1cTL7t9V@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 May 2016 14:46:22 Florian Fainelli wrote:
> 
> > 
> >> +- brcm,gen: integer that indicates desired forced generation of link: 1 => 2.5
> >> +  Gbps, 2 => 5.0 Gbps, 3 => 8.0 Gbps. Will override the auto-negotation if
> >> +  specified.
> > 
> > to repeat my earlier comment from v1:
> > 
> > Shouldn't the link generation be probed automatically?
> 
> It is, but if the property is present, we can foce the link negotiation,
> We have had cases where this was desired and helpful.
> 

Right, I missed that this is listed as 'optional', so that seems
perfectly fine.

Thanks,

	Arnd
