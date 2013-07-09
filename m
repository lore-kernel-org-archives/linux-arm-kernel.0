From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 9 Jul 2013 10:27:53 +0200
Subject: [PATCH v2 2/5] ARM: AT91: DTS: sam9x5: add SSC DMA parameters
In-Reply-To: <20130708150756.GL27646@sirena.org.uk>
References: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
 <1373290193-25300-3-git-send-email-richard.genoud@gmail.com>
 <20130708150756.GL27646@sirena.org.uk>
Message-ID: <CACQ1gAgnRBr6Eu7sgbzNF2kmm18-zn_dGKZN45RaxXGd1kwL-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/8 Mark Brown <broonie@kernel.org>:
> On Mon, Jul 08, 2013 at 03:29:50PM +0200, Richard Genoud wrote:
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> ---
>>  arch/arm/boot/dts/at91sam9x5.dtsi |    3 +++
>
> There was no binding document in your first patch - there should be one
> for any new DT bindings.
The dma binding is documented here
Documentation/devicetree/bindings/dma/atmel-dma.txt
But you're right, I shoud update
Documentation/devicetree/bindings/misc/atmel-ssc.txt.

Thanks



-- 
for me, ck means con kolivas and not calvin klein... does it mean I'm a geek ?
