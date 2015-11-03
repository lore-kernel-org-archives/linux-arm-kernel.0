From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 3 Nov 2015 21:36:28 +0100
Subject: wrong value in kirkwood-ts219.dtsi
In-Reply-To: <56390400.5070408@gmail.com>
References: <56390400.5070408@gmail.com>
Message-ID: <20151103203628.GA25118@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 07:59:12PM +0100, Helmut Klein wrote:
> Hallo,
> 
> the line "reg = <0x12000 0x100>;" in the section "poweroff at 12100" is
> not correct
> 
> The base address of uart1, which is connected to the pic controller
> is 0x12100 and not 0x12000

Yes, it is wrong.

Do you want to produce a proper patch for this?

Thanks
	Andrew
