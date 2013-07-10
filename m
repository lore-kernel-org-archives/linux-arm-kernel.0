From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Jul 2013 11:01:50 +0100
Subject: [PATCH v4 3/7] Documentation: DT: update atmel SSC with DMA
 binding
In-Reply-To: <CACQ1gAhK2yN2uhewq8XGOidLCDfOhgRvzE1o0b1krK1DjYj-dA@mail.gmail.com>
References: <1373372929-17800-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-4-git-send-email-richard.genoud@gmail.com>
 <20130709150543.GE27646@sirena.org.uk>
 <CACQ1gAhK2yN2uhewq8XGOidLCDfOhgRvzE1o0b1krK1DjYj-dA@mail.gmail.com>
Message-ID: <20130710100150.GB24508@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 11:48:27AM +0200, Richard Genoud wrote:
> 2013/7/9 Mark Brown <broonie@kernel.org>:

> > ...this first example is now invalid and should probably just be being
> > extended with the new required properties.

> Well, I have to rewrite that to make it clearer.
> The thing is:
> with "atmel,at91rm9200-ssc" the SSC doesn't work with DMA.
> with "atmel,at91sam9g45-ssc", the SSC work ONLY with DMA.

> So the dmas/dma-names properties are only required for g45-ssc, and
> useless for rm9200-ssc

> Maybe the best will be to write a paragraph for g45-ssc and another
> for rm9200-ssc, even if there's some identical lines between them.

OK, or just write a section "Required for devices with compatible X".
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130710/2065b88d/attachment.sig>
