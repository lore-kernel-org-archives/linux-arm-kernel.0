From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Jul 2013 10:32:54 +0100
Subject: [PATCH v2 2/5] ARM: AT91: DTS: sam9x5: add SSC DMA parameters
In-Reply-To: <CACQ1gAgnRBr6Eu7sgbzNF2kmm18-zn_dGKZN45RaxXGd1kwL-Q@mail.gmail.com>
References: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
 <1373290193-25300-3-git-send-email-richard.genoud@gmail.com>
 <20130708150756.GL27646@sirena.org.uk>
 <CACQ1gAgnRBr6Eu7sgbzNF2kmm18-zn_dGKZN45RaxXGd1kwL-Q@mail.gmail.com>
Message-ID: <20130709093254.GP27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 10:27:53AM +0200, Richard Genoud wrote:

> The dma binding is documented here
> Documentation/devicetree/bindings/dma/atmel-dma.txt
> But you're right, I shoud update
> Documentation/devicetree/bindings/misc/atmel-ssc.txt.

No, you need to write a binding for this machine driver - the DMA and
SSC need to be documented as well but so too does the audio driver that
pulls them together with the CODEC.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130709/b95f65f1/attachment.sig>
