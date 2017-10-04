From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 04 Oct 2017 14:00:22 +1030
Subject: [PATCH 1/8] ARM: dts: aspeed: Move pinctrl subnodes to improve
 readability
In-Reply-To: <20170928075149.8154-2-joel@jms.id.au>
References: <20170928075149.8154-1-joel@jms.id.au>
 <20170928075149.8154-2-joel@jms.id.au>
Message-ID: <1507087822.5452.1.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-09-28 at 17:21 +0930, Joel Stanley wrote:
> > From: Andrew Jeffery <andrew@aj.id.au>
> 
> Moving the subnodes out of the pinctrl node declaration to a reference
> allows easier access to the remaining parts of the devicetree.
> 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > Reviewed-by: Xo Wang <xow@google.com>
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> ?arch/arm/boot/dts/aspeed-g4.dtsi | 1483 ++++++++++++++++++------------------
> ?arch/arm/boot/dts/aspeed-g5.dtsi | 1549 +++++++++++++++++++-------------------
> ?2 files changed, 1518 insertions(+), 1514 deletions(-)

I hate the way the diff came out for the g5, it's almost impossible to
read. Also not sure how useful it is to ack my own patch, but given the
rebasing it has suffered:

Acked-by: Andrew Jeffery <andrew@aj.id.au>

Cheers,

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171004/feee3ef4/attachment-0001.sig>
