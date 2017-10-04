From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 04 Oct 2017 15:51:30 +1030
Subject: [PATCH 2/8] ARM: dts: aspeed: Reorder ADC node
In-Reply-To: <CACPK8XfENyKdcV1ZgPrf-Kv+H5BsyQcaCX9ha_gNgD3gcuBUwg@mail.gmail.com>
References: <20170928075149.8154-1-joel@jms.id.au>
 <20170928075149.8154-3-joel@jms.id.au> <1507088159.5452.3.camel@aj.id.au>
 <CACPK8XfENyKdcV1ZgPrf-Kv+H5BsyQcaCX9ha_gNgD3gcuBUwg@mail.gmail.com>
Message-ID: <1507094490.5452.18.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-10-04 at 14:43 +0930, Joel Stanley wrote:
> > > > > > +???????????????????? adc: adc at 1e6e9000 {
> > > +???????????????????????????? compatible = "aspeed,ast2500-adc";
> > > +???????????????????????????? reg = <0x1e6e9000 0xb0>;
> > 
> > Did you intend to change the size cell value here? It now matches the g4, but
> > there was an explicit comment about the size for some reason in the -hunk
> > below. It's probably worth an explicit call-out if we're going to change it.
> 
> Looks ok to me.

Yeah, sorry, was looking in the wrong spot :/

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171004/26ad933b/attachment.sig>
