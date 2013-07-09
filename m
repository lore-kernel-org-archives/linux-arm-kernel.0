From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 9 Jul 2013 11:46:03 +0200
Subject: [PATCH v2 2/5] ARM: AT91: DTS: sam9x5: add SSC DMA parameters
In-Reply-To: <20130709093254.GP27646@sirena.org.uk>
References: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
 <1373290193-25300-3-git-send-email-richard.genoud@gmail.com>
 <20130708150756.GL27646@sirena.org.uk>
 <CACQ1gAgnRBr6Eu7sgbzNF2kmm18-zn_dGKZN45RaxXGd1kwL-Q@mail.gmail.com>
 <20130709093254.GP27646@sirena.org.uk>
Message-ID: <CACQ1gAhNAnyfaDSCxqAv11KZA2bGTdcfgcBjprAu3Ecw1y02mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/9 Mark Brown <broonie@kernel.org>:
> On Tue, Jul 09, 2013 at 10:27:53AM +0200, Richard Genoud wrote:
>
>> The dma binding is documented here
>> Documentation/devicetree/bindings/dma/atmel-dma.txt
>> But you're right, I shoud update
>> Documentation/devicetree/bindings/misc/atmel-ssc.txt.
>
> No, you need to write a binding for this machine driver - the DMA and
> SSC need to be documented as well but so too does the audio driver that
> pulls them together with the CODEC.
Ok, I understand !

Richard.
