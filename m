From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 04 Oct 2017 15:11:50 +1030
Subject: [PATCH 3/8] ARM: dts: aspeed: Add I2C buses
In-Reply-To: <20170928075149.8154-4-joel@jms.id.au>
References: <20170928075149.8154-1-joel@jms.id.au>
 <20170928075149.8154-4-joel@jms.id.au>
Message-ID: <1507092110.5452.11.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-09-28 at 17:21 +0930, Joel Stanley wrote:
> Now with an upstream i2c bus driver, we can add??the 14 i2c buses that
> exist in ASPEED G4 and G5 generation SoCs.
> 
> It also adds aliases for the 14 built-in I2C busses to ensure userspace
> sees the numbering staring from zero and counting up.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171004/9b11429c/attachment-0001.sig>
